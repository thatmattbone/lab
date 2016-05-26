package mbone

object Driver {
  def main(args: Array[String]) {
    val p = new Palindrome
    println("Hello, world!")
    println(p.isPalindrome("asdf"))
    println(p.isPalindrome("racecar"))
  }
}