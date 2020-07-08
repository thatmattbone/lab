package main

import "fmt"

type MyInt int

type Cat interface {
	Purr() 
	Meow()
}

type Alice struct {
	weight int
}

func (i MyInt) Triple() MyInt {
	return i * 3
}



func main() {
	var i MyInt = 3
	fmt.Printf("%d\n", i.Triple())
}