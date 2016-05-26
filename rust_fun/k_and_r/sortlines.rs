use std;
use k_and_r;


fn main(args: [str]) {
    let lines = k_and_r::sorting::read_lines(args[1]);
    let sorted_lines = std::sort::merge_sort({ |x, y| x < y }, lines);       

    k_and_r::sorting::write_lines(sorted_lines);
}