package main

import ( 
	"fmt"
	"http"
	"flag"
)


var mqueue *MemoQueue


func PutHandler(w http.ResponseWriter, r *http.Request) {

	key := r.FormValue("key")
	value := r.FormValue("value")

	// TODO must be a better way to enforce the values being set...
	if len(key) != 0 && len(value) != 0 {
		mqueue.Put(key, value)
		fmt.Fprintf(w, "ok")
	}

}


func GetHandler(w http.ResponseWriter, r *http.Request) {
	key := r.FormValue("key")

	if len(key) != 0 {
		value, ok := mqueue.Get(key)
		if ok {
			fmt.Fprintf(w, "%s", value)
		}
	}
}

func StatsHandler(w http.ResponseWriter, r *http.Request) {	
	for queue, mylist := range mqueue.table {
		fmt.Fprintf(w, "%s: %d<br/>", queue, mylist.Len())
	}
}


func slam(queue string, max int, done chan int) {
	for i := 0; i<max; i++ {
		_, _, err := http.Get(fmt.Sprintf("http://localhost:8080/put?key=%s&value=%d", queue, i))
		if(err != nil) {
			//just retry incessantly if anything goes wrong
			i = i - 1
		}
	}
	done <- 1
}

func main() {	

	var benchmark = flag.Bool("benchmark", false, "benchmark an already running server")

	flag.Parse()

	if(*benchmark) {
		done := make(chan int)

		go slam("foo", 10000, done)
		go slam("bar", 10000, done)
		go slam("foo", 10000, done)
		go slam("bar", 10000, done)

		<-done
		<-done
		<-done
		<-done

	} else {
		mqueue = NewMemoQueue()

		http.HandleFunc("/put", PutHandler)
		http.HandleFunc("/get", GetHandler)
		http.HandleFunc("/stats", StatsHandler)

		http.ListenAndServe(":8080", nil)
	}
}