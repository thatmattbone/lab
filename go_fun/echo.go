package main

import (
	"os"
	"flag"
)

var omitNewLine = flag.Bool("n", false, "don't print final newline")

const (
	Space = " "
	Newline = " "
)

func main() {
	flag.Parse()
	var s = ""
	for i := 0; i < flag.NArg(); i++ {
		if i > 0 {
			s+=Space
		}
		s += flag.Arg(i)
	}
	if !*omitNewLine {
		s += Newline
	}
	os.Stdout.WriteString(s)
}