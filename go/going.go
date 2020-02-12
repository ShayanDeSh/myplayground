package main

import (
	"fmt" // standard library
	//	"io/ioutil" // I/O
	//	"math"      // math
	//	"net/http"  // web server
	//	"os"        // os functions
	//	"strconv"   // converting strings
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
	g := 'Σ'           // rune type, an alias for int32, holds a unicode code point
	f := 3.1315        // float64
	c := 3 + 4i        // complex128, represented internally with two floadt64

	var u uint = 7 // Unsigned,  but implementation dependent size as with int
	var pi float32 = 22. / 7

	n := byte('\n') // byte an alias for uint8

	var a4 [4]int                    // an array of 4 ints, initialized to all 0
	a5 := [...]int{3, 1, 5, 10, 100} // an array initialized with a fixed size of five
}
