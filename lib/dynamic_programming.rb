require "byebug"

class DynamicProgramming

  def initialize
    @blair_cache = { 1 => 1, 2 => 2 }
    @frog_cache = [[], [[1]], [[1,1],[2]], [[1,1,1],[1,2],[2,1],[3]]]
    @super_frog_cache = [[], [[1]]]
  end

  # 1, 2, 6, 13
  def blair_nums(n)
    return @blair_cache[n] if @blair_cache[n]

    ans = blair_nums(n - 1) + blair_nums(n - 2) + ((n - 1) * 2) - 1
    @blair_cache[n] = ans
    ans
  end

  def build_blair_nums_cache(n)
    cache = { 1 => 1, 2 => 2 }
    (3..n).each do |i|
      cache[i] = cache[i - 1] + cache[i - 2] + ((i - 1) * 2) - 1
    end
    cache
  end

  def blair_nums_bu(n)
    cache = build_blair_nums_cache(n)
    cache[n]
  end

  def frog_hops_bottom_up(n)
    cache = frog_cache_builder(n)
    cache
  end

  def frog_cache_builder(n)
    return @frog_cache[n] if @frog_cache[n]

    # [[1]] << 3 -> [[1,3]]
    # [[1,1],[2]] << 2 -> [[1,1,2],[2,2]]
    # [[1,1,1],[1,2],[2,1],[3]] << 1 -> [[1,1,1,1],[1,2,1],[2,1,1],[3,1]]

    (4..n).each do |i|
      ans = []

      (1..3).each do |offset|
        @frog_cache[i - offset].each do |steps|
          ans << steps + [offset]
        end
      end

      @frog_cache[i] = ans
    end

    @frog_cache[n]
  end

  def frog_hops_top_down(n)
    frog_hops_top_down_helper(n)
  end

  def frog_hops_top_down_helper(n)
    return @frog_cache[n] if @frog_cache[n]

    ans = []
    (1..3).each do |offset|
      frog_hops_top_down_helper(n - offset).each do |steps|
        ans << steps + [offset]
      end
    end
    @frog_cache[n] = ans

    ans
  end

  # max jumps = 4
  # []
  # [1]
  # [[1,1],[2]]
  # [[1,1,1],[2,1],[1,2],[3]]
  # [[1,1,1,1],[2,1,1],[1,2,1],[3,1][1,1,2],[2,2],[1,3],[4]]

  # [[1,1,1,1,1],[2,1,1,1],[1,2,1,1],[3,1,1][1,1,2,1],[2,2,1],[1,3,1],[4,1]]
  # [[1,1,1,2],[2,1,2],[1,2,2],[3,2][1,1,3],[2,3],[1,4],[4]]

  # max jump = 2
  # []
  # [1]
  # [[1,1],[2]]
  # [[1,1,1],[2,1],[1,2],[2]] Only increment if last element is < max jump

  def super_frog_hops(n, max_jump)
    return [[]] if n == 0
    return [[1]] if n == 1

    ans = []

    super_frog_hops(n - 1, max_jump).each do |steps|
      ans << steps + [1]
      ans << steps[0...-1] + [steps.last + 1] if steps.last < max_jump
    end

    ans
  end

  def knapsack(weights, values, capacity)
    return 0 if capacity == 0
    values[0]
  end

  # Helper method for bottom-up implementation
  def knapsack_table(weights, values, capacity)

  end

  def maze_solver(maze, start_pos, end_pos)
  end
end
