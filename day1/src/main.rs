use std::env;
use std::fs;

type Result<T> = ::std::result::Result<T, Box<dyn ::std::error::Error>>;

fn main() -> Result<()>{
    let args: Vec<String> = env::args().collect();

    let filename = &format!("{}", &args[1]);

    let input = fs::read_to_string(filename)
        .expect("Error reading file");

    part1(&input)?;
    part2(&input)?;

    Ok(())
}

/**
 * Part 1
 *
 * 1. Identify line pair that when combined sums 2020
 * 2. Return multiplication of line pair
 */
fn part1(input: &String) -> Result<()> {
    let target: u32 = 2020;
    let lines: Vec<u32> = input.lines()
        .map(|s| s.parse().expect("Error parsing value"))
        .collect();

    for i in 0..lines.len() {
        for j in i+1..lines.len() {
            if (&lines[i] + &lines[j]) == target {
                println!("{} + {} = {}", &lines[i], &lines[j], target);
                println!("{} * {} = {}", &lines[i], &lines[j], &lines[i] * &lines[j]);
            }
        }
    }

    Ok(())
}

/**
 * Part 2
 */
fn part2(input: &String) -> Result<()> {
    let target: u32 = 2020;
    let lines: Vec<u32> = input.lines()
        .map(|s| s.parse().expect("Error parsing value"))
        .collect();

    for i in 0..lines.len() {
        for j in i+1..lines.len() {
            for k in j+1..lines.len() {
                if (&lines[i] + &lines[j] + &lines[k]) == target {
                    println!("{} + {} + {} = {}", &lines[i], &lines[j], &lines[k], target);
                    println!("{} * {} * {} = {}", &lines[i], &lines[j], &lines[k], &lines[i] *
                        &lines[j] * &lines[k]);
                }
            }
        }
    }

    Ok(())
}