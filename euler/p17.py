text_map = {1: 'one',
             2: 'two',
             3: 'three',
             4: 'four',
             5: 'five',
             6: 'six',
             7: 'seven',
             8: 'eight',
             9: 'nine',
             10: 'ten',
             11: 'eleven',
             12: 'twelve',
             13: 'thirteen',
             14: 'fourteen',
             15: 'fifteen',
             16: 'sixteen',
             17: 'seventeen',
             18: 'eighteen',
             19: 'nineteen',
             20: 'twenty',
             30: 'thirty',
             40: 'forty',
             50: 'fifty',
             60: 'sixty',
             70: 'seventy',
             80: 'eighty',
             90: 'ninety',
             100: 'hundred',
             1000: 'thousand',
            }


def convert_to_text(num):
    if num <= 20:
        return text_map[num]
    elif num < 100:
        num, remainder = divmod(num, 10)
        ret_text = text_map[num * 10]
        if remainder:
            ret_text += " " + text_map[remainder]
        return ret_text
    elif num < 1000:
        num, remainder = divmod(num, 100)
        ret_text = text_map[num] + " " + text_map[100]
        if remainder:
            ret_text += " and " + convert_to_text(remainder)
        return ret_text
    else:
        return "one thousand"


if __name__ == "__main__":
    letter_count = 0
    for i in range(1, 1001):
        converted = convert_to_text(i)
        print "%s %s" % (i, converted)

        letter_count += len("".join(converted.split(" ")))

    print letter_count