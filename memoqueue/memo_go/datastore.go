package main

import ( 
	"container/list"
	"sync"
)


type MemoQueue struct {
	lock sync.RWMutex
	table map[string](*list.List)
}

func NewMemoQueue() *MemoQueue {	
	var memoqueue = new(MemoQueue)
	memoqueue.table = make(map[string](*list.List))
	return memoqueue
}


// Put a a value into the queue specified by key
func (m *MemoQueue) Put(key string, value string) {

	m.lock.Lock()

	queue, found := m.table[key]
	if !found {
		var newlist *list.List = list.New()
		m.table[key] = newlist
		queue = newlist
	} 
	
	queue.PushBack(value)

	m.lock.Unlock()
}


// Get a value from the queue specified by key
func (m *MemoQueue) Get(key string) (string, bool) {

	m.lock.RLock()

	/*do a check for membership and panic*/
	queue, ok := m.table[key]
	if !ok { return "", ok /* TODO find something better to return here than an empty string */ }

	var first = queue.Front()
	queue.Remove(first)

	retVal, _ := first.Value.(string)

	m.lock.RUnlock()

	return retVal, true
}