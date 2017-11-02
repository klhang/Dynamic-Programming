class DynamicProgramming
  attr_accessor :blair_cache

  def initialize
    @blair_cache = {1 => 1, 2 => 2}
    @frog_cache = [[[]], [[1]], [[1, 1], [2]]]
  end

  def blair_nums(n)
    return @blair_cache[n] if @blair_cache[n]
    odd_num = 1
    (1...n-1).each do |i|
      odd_num += 2
    end
    @blair_cache[n] = blair_nums(n-1) + blair_nums(n-2) + odd_num
  end

  def frog_hops_bottom_up(n)
    frog_cache_builder(n)[n]
  end

  def frog_cache_builder(n)

  end

  def frog_hops_top_down(n)
    @frog_cache = [[[]], [[1]], [[1, 1], [2]]]
    frog_hops_top_down_helper(n)
  end

  def frog_hops_top_down_helper(n)
    return @frog_cache[n] if @frog_cache[n]
    new_way_set = []
    (1..3).each do |first_step|
      frog_hops_top_down_helper(n - first_step).each do |way|
        new_way = [first_step]
        way.each do |step|
          new_way << step
        end
        new_way_set << new_way
      end
    end
    @frog_cache[n] = new_way_set
  end

  def super_frog_hops(n, k)
    ways_collection = [[[]], [[1]]]

    return ways_collection[n] if n < 2

    (2..n).each do |i|
      new_way_set = []
      (1..k).each do |first_step|
        next if i - first_step < 0
        ways_collection[i - first_step].each do |way|
          new_way = [first_step]
          way.each do |step|
            new_way << step
          end
          new_way_set << new_way
        end
      end
      ways_collection << new_way_set
    end

    ways_collection[n]
  end

  def knapsack(weights, values, capacity)
    return 0 if capacity == 0 || weights.length == 0
    solution_table = knapsack_table(weights, values, capacity)
    solution_table[capacity][-1]
  end

  # Helper method for bottom-up implementation
  def knapsack_table(weights, values, capacity)
    solution_table = []
    # Build solutions for knapsacks of increasing capacity
    (0..capacity).each do |i|
      solution_table[i] = []
      # go through the weights one by one, by index
      (0..weights.length - 1).each do |j|
        if i == 0
          # if the capacity is 0, then 0 is how much value can be placed in any slot
          solution_table[i][j] = 0
        elsif j == 0
          # for the first item in our list, you must check for capacity
          # if there is, then you enter its value in the first slot, otherwise 0
          solution_table[i][j] = weights[0] > i ? 0 : values[0]
        else
          # the first option is the entry from considering the previous item at this capacity
          option1 = solution_table[i][j - 1]
          # the second option (assuming enough capacity) is the entry from a smaller bag
          # (with enough room for this item) plus this item's value
          option2 = i < weights[j] ? 0 : solution_table[i - weights[j]][j - 1] + values[j]
          # the actual entry for this item is the optimum of the two choices
          optimum = [option1, option2].max
          solution_table[i][j] = optimum
        end
      end
    end

    solution_table
  end

  def maze_solver(maze, start_pos, end_pos)
  end
end
