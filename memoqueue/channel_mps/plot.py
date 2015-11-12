import matplotlib.pyplot as plt

if __name__ == '__main__':
    xs = []
    ys = []

    for line in open("out"):
        s = line.split()
        xs.append(int(s[0]))
        ys.append(int(s[1]))


    ys = [y/1000000000. for y in ys]
    plt.plot(xs[10:], ys[10:], linestyle='solid', marker='.')
    plt.xlabel('Iteration')
    plt.ylabel('Seconds to receive 10k messages')    
    plt.show()
