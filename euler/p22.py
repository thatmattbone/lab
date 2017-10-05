
def alpha_num(x):
    return ord(x) - 64

def score(name):
    return sum([alpha_num(letter) for letter in name])

file = open('names.txt').readlines()
names = [name.strip('"') for name in file[0].split(',')]
names.sort()

i = 0
total_score = 0
for name in names:
    i+=1
    if(name == 'COLIN'):
        print(name)
        print(score(name))
        print(i)
    total_score += (score(name)*i)
print(total_score)
    
