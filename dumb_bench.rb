#!/usr/bin/env ruby

$times = 10 ** 8

def thread_function(count)
  return Thread.new(count) do |cnt|
    v = 1
    cnt.times do
      v += 1
    end
    v
  end
end

def float_thread_function(count)
  return Thread.new(count) do |cnt|
    cnt >> 4
    v = 1.0
    cnt.times do
      v += 1.0
    end
    v
  end
end


def get_nproc
  nproc = `nproc`.to_i
  if ARGV.length == 0
    return nproc
  else
    return nproc/2
  end
end


def test
  a = Time.now
  n_proc = get_nproc
  count = $times/n_proc
  arr = []
  n_proc.times do
    arr << thread_function(count)
  end
  arr.each do |x|
    x.join
  end
  b = Time.now
  puts "Integer Test -- Elapsed time: #{(b-a)*1000}ms"
end

def float_test
  a = Time.now
  n_proc = get_nproc
  count = $times/n_proc
  arr = []
  n_proc.times do
    arr << float_thread_function(count)
  end
  arr.each do |x|
    x.join
  end
  b = Time.now
  puts "Float Test -- Elapsed time: #{(b-a)*1000}ms"
end


test

float_test
