package mbone

class Palindrome {

  def isPalindrome(possiblePalindrome: java.lang.String): Boolean = {
    if(possiblePalindrome == possiblePalindrome.reverse) {
      return true;
    }
    return false;
  }
}