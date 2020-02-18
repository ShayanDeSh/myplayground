package main

import (
	"fmt" // standard library
	//	"io/ioutil" // I/O
	//	"math"      // math
	//	"net/http"  // web server
	"os" // os functions
	//	"strconv"   // converting strings
	"log"
)

func main() {

	// printing in new line
	fmt.Println("Hello world!")

	// function call
	beyondHello()

}

func beyondHello() {

	//variables must be declared before ud
	var x int

	// use := to declare and asighn
	y := 4

	// returning multiple value
	sum, prod := learnMultiple(x, y)
	fmt.Println("sum:", sum, "prod:", prod)
	learnTypes()
}

func learnMultiple(x, y int) (sum, prod int) {
	sum = x + y
	prod = x * y
	return
}

func learnTypes() {
	str := "Learn Go!" // string

	g := 'Σ'    // rune type, an alias for int32, holds a unicode code point
	f := 3.1315 // float64
	c := 3 + 4i // complex128, represented internally with two floadt64

	var u uint = 7 // Unsigned,  but implementation dependent size as with int
	var pi float32 = 22. / 7

	n := byte('\n') // byte an alias for uint8

	var a4 [4]int // an array of 4 ints, initialized to all 0

	a5 := [...]int{3, 1, 5, 10, 100} // an array initialized with a fixed size of five
	a4_cpy := a4                     // a4_cpy is a copy of a4, two separate instances.

	a4_cpy[0] = 25
	fmt.Println(a4_cpy[0] == a4[0]) // false

	// slices have dynamic size.
	s3 := []int{4, 5, 9}
	s4 := make([]int, 4) // Allocates slice of 4 ints, initialized to all 0.
	var s2 [][]float64
	bs := []byte("a slice")

	s3_cpy := s3 // slices have refrence semantics. both variables point to the same instances.
	s3_cpy[0] = 0
	fmt.Println(s3_cpy[0] == s3[0]) // true

	s := []int{1, 2, 3}
	s = append(s, 4, 5, 6)
	fmt.Println(s)

	s = append(s, []int{7, 8, 9}...) // elipsis unpack the slice
	fmt.Println(s)

	m := map[string]int{"three": 3, "four": 4}
	m["one"] = 1

	_, _, _, _, _, _, _, _, _, _, _ = str, s2, g, f, c, u, pi, n, a5, s4, bs

	file, err := os.Create("output.txt")

	if err != nil {
		log.Fatal(err)
	}

	fmt.Fprint(file, "This is how you write to a file, by the way")
	file.Close()

	// pointer and stuffs
	p, q := learnMemory()
	fmt.Println(*p, *q) // * follows a pointer.

	learnFlowControl()
}

func learnMemory() (p, q *int) {
	p = new(int)
	s := make([]int, 20)
	s[3] = 7
	r := -2
	return &s[3], &r
}

func learnFlowControl() {

}
