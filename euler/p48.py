def n_to_n(n):
    answer = 1
    for i in range(1, n+1):
        answer *= n
    return answer

def n_to_n_seq(max):
    for i in range(1, max+1):
        yield n_to_n(i)

print(sum(n_to_n_seq(1000)))
