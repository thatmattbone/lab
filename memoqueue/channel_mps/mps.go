package main

import ( 
	"fmt"
	"time"
)

type MovingAverage struct {
	k int64 
	pos int64
	ts []int64
}

func NewMovingAverage(k int64) *MovingAverage {
	var avg = new(MovingAverage)
	avg.k = k
	avg.ts = make([]int64, k)
	avg.pos = 0
	return avg
}

func (avg *MovingAverage) CurrentAverage() int64 {
	var total int64
	total = 0

	var i int64
	for i=0; i<avg.k; i++ {
		total += avg.ts[i]
	}
	return total/avg.k
}

func (avg *MovingAverage) SetNextT(t int64) {
	avg.ts[avg.pos] = t
	avg.pos = (avg.pos + 1) % avg.k
}


func sender(pipe chan int) {

	var i int64
	for i=0; i<10000000; i++ {
		pipe <- 1		
	}
	pipe <- -1
}

func receiver(pipe chan int, done_pipe chan int) {
	
	prevTime := time.Nanoseconds()
	var newTime int64

	msg_count := 0

	stats := NewMovingAverage(10)

	j := 0

	for i:=true; i!=false;  {
		val := <-pipe
		msg_count++
		if val == -1 {
			i=false
		}

		if msg_count == 100000 {
			newTime = time.Nanoseconds()

			stats.SetNextT(newTime - prevTime)
			//fmt.Printf("%d %d\n", j, stats.CurrentAverage())
			fmt.Printf("%d %d\n", j, newTime-prevTime)			
			
			j++
			msg_count=0
			prevTime = newTime
		}
	}
	done_pipe <- 1 
}

func main() {	

	pipe := make(chan int)
	done_pipe := make(chan int)
	go sender(pipe)
	go receiver(pipe, done_pipe)

	<-done_pipe
}