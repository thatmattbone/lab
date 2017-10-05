
class TriangleNumber(object):
    def __init__(self):
        self.max_seen = -1
        self.triangle_nums = set()
        self.triangle_number_generator = self._triangle_number_generator()
    
    def _triangle_number_generator(self):
        n = 1
        while True:
            yield int(.5 * n * (1 + n))
            n += 1
        
    def is_triangle_number(self, n):
        while n > self.max_seen:
            next_num = self.triangle_number_generator.next()
            self.max_seen = next_num
            self.triangle_nums.add(next_num)

        return n in self.triangle_nums
            
def letter_num(letter):
    return ord(letter) - 64

if __name__ == "__main__":
    t = TriangleNumber()
    words = []
    with open("words.txt", "rb") as words_file:
        raw_words = words_file.read()
        for word in raw_words.split(","):
            words.append(word.strip('"'))

    triangle_num_count = 0
    for word in words:
        word_value = sum([letter_num(letter) for letter in word])
        if t.is_triangle_number(word_value):
            triangle_num_count += 1

    print triangle_num_count
