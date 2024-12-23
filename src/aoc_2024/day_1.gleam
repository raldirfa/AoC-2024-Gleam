import gleam/int
import gleam/list
import gleam/result
import gleam/string

pub fn pt_1(input: List(List(Int))) {
  let left =
    input
    |> list.map(list.first)
    |> list.map(result.unwrap(_, -1))
    |> list.sort(int.compare)

  let right =
    input
    |> list.map(list.last)
    |> list.map(result.unwrap(_, -1))
    |> list.sort(int.compare)

  let result =
    list.zip(left, right)
    |> list.map(tuple_sub)
    |> int.sum

  result
}

pub fn pt_2(input: List(List(Int))) {
  let left =
    input
    |> list.map(list.first)
    |> list.map(result.unwrap(_, -1))

  let right =
    input
    |> list.map(list.last)
    |> list.map(result.unwrap(_, -1))

  let result =
    left
    |> list.map(fn(x) { int.multiply(x, count_in_list(x, right)) })
    |> int.sum

  result
}

pub fn parse(input: String) -> List(List(Int)) {
  input
  |> string.split("\n")
  |> list.map(first_and_last)
}

fn first_and_last(input: String) {
  input
  |> string.split("   ")
  |> list.map(int.parse)
  |> list.map(result.unwrap(_, -1))
}

fn tuple_sub(tup: #(Int, Int)) -> Int {
  int.absolute_value(tup.0 - tup.1)
}

fn count_in_list(num: Int, list: List(Int)) -> Int {
  list
  |> list.filter(fn(x) { x == num })
  |> list.length
}
