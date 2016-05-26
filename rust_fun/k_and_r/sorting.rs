use std;
import io::reader_util; //this adds the the reader_util methods to io::reader instances

#[doc = "Read a bunch of lines from the specified filename."]
fn read_lines(filename: str) -> [str] {
    let mut lines = [];

    let rdr = result::get(io::file_reader(filename));
    while !rdr.eof() {
        let stripped_line = str::trim(rdr.read_line());
        if !str::is_whitespace(stripped_line) {
            lines += [stripped_line];
        }
    }
    // alt io::file_reader("lines") {
    //   result::err(foo) { 
    //     io::println("fuck"); 
    //   }
    //   result::ok(line_reader) {
    //     log(error, line_reader.read_line());       
    //   }
    // }
    ret lines;
}

#[doc = "Write a bunch of lines to stdout."]
fn write_lines(lines: [str]) {
    for vec::each(lines) { |elem|
        io::println(elem);
    }
}

#[doc = "Sort a bunch of lines"]
fn sort_lines<T: copy>(lines: [T]) -> [T] { //TODO figure out what it means for something to be of the "copyable kind"
    //TODO replace this with the faster in place sort
    std::sort::merge_sort({ |x, y| x < y }, lines)
}

#[test]
fn test_sort_str_lines() {
    let sorted_lines = sort_lines(["b", "a", "c"]);

    assert sorted_lines[0] == "a";
    assert sorted_lines[1] == "b";
    assert sorted_lines[2] == "c";
}


#[test]
fn test_sort_int_lines() {
    let sorted_lines = sort_lines([3, 1, 2]);

    assert sorted_lines[0] == 1;
    assert sorted_lines[1] == 2;
    assert sorted_lines[2] == 3;
}

