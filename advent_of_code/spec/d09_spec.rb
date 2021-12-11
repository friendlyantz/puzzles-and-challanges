# require_relative '../d09/09_smoke'
require_relative '../d09/09_smoke'

RSpec.describe 'Day 9 Smoke' do
  let(:cal_data) do
    "2199943210
3987894921
9856789892
8767896789
9899965678
"
  end

  let(:matrix) do
    [[2, 1, 9, 9, 9, 4, 3, 2, 1, 0],
     [3, 9, 8, 7, 8, 9, 4, 9, 2, 1],
     [9, 8, 5, 6, 7, 8, 9, 8, 9, 2],
     [8, 7, 6, 7, 8, 9, 6, 7, 8, 9],
     [9, 8, 9, 9, 9, 6, 5, 6, 7, 8]]
  end
  let(:array_of_lines) do
    [2_199_943_210,
     3_987_894_921,
     9_856_789_892,
     8_767_896_789,
     9_899_965_678]
  end

  describe 'data_prep' do
    it '# data_prep breaks down data into lines' do
      expect(data_prep(cal_data)).to eq([2_199_943_210,
                                         3_987_894_921,
                                         9_856_789_892,
                                         8_767_896_789,
                                         9_899_965_678])
    end

    it '# generate_mtrix breaks down data into 2d matrix' do
      expect(generate_mtrix(cal_data).size).to eq(5)
      expect(generate_mtrix(cal_data).first.size).to eq(10)
      expect(generate_mtrix(cal_data)).to eq(matrix)
    end
  end

  describe 'low points' do
    it ' first_line_scan(first_line, second_line) finds low points' do
      expect(first_line_scan([5, 6, 3, 2], [7, 3, 3, 4])).to eq [5, 2]
      expect(first_line_scan(matrix[0], matrix[1])).to eq [1, 0]
    end

    it 'find_low_points outputs array of low point values' do
      expect(find_low_points(matrix)).to eq [1, 0, 5, 5]
    end

    it 'calculates the sum of risk factors of low points' do
      expect(low_points_risk_factor([1, 0, 5, 5])).to eq 16
    end
  end
end
