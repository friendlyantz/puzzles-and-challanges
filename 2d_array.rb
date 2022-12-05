arr = Array.new(6)
max = -10_000_000

6.times do |i|
  arr[i] = gets.rstrip.split(' ').map(&:to_i)
end

6.times do |i|
  6.times  do |j|
    next unless (j + 2) < 6 and (i + 2) < 6

    sum = (arr[i][j] + arr[i][j + 1] + arr[i][j + 2]) +
          (arr[i + 1][j + 1]) + (arr[i + 2][j] + arr[i + 2][j + 1] + arr[i + 2][j + 2])

    max = sum if sum > max
  end
end

puts max
