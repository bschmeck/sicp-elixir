defmodule BinaryMobile do
  def make(left, right), do: [left | right]
  def left(mobile), do: hd mobile
  def right(mobile), do: tl mobile

  def total_weight(mobile), do: Branch.weight(left(mobile)) + Branch.weight(right(mobile))

  def balanced?(n) when is_number(n), do: true
  def balanced?(mobile) do
    Branch.torque(left(mobile)) == Branch.torque(right(mobile)) &&
      balanced?(Branch.structure(left(mobile))) &&
      balanced?(Branch.structure(right(mobile)))
  end
end

defmodule Branch do
  def make(len, structure), do: [len, structure]
  def len(branch), do: hd branch
  def structure(branch), do: hd tl branch

  def weight(branch) do
    case structure(branch) do
      n when is_number(n) -> n
      mobile -> BinaryMobile.total_weight(mobile)
    end
  end

  def torque(branch) do
    len(branch) * weight(branch)
  end
end

ExUnit.start

defmodule BinaryMobileTests do
  use ExUnit.Case, async: true

  test "mobiles have selectors" do
    left = Branch.make(1, 1)
    right = Branch.make(2, 2)
    mobile = BinaryMobile.make(left, right)
    assert BinaryMobile.left(mobile) == left
    assert BinaryMobile.right(mobile) == right
  end

  test "branches have selectors" do
    branch = Branch.make(5, 10)
    assert Branch.len(branch) == 5
    assert Branch.structure(branch) == 10
  end

  test "branches have weight" do
    branch = Branch.make(5, 10)
    assert Branch.weight(branch) == 10
  end

  test "branches with sub-mobiles have weight" do
    subbranch = Branch.make(1, 1)
    mobile = BinaryMobile.make(subbranch, subbranch)
    branch = Branch.make(5, mobile)
    assert Branch.weight(branch) == BinaryMobile.total_weight(mobile)
  end

  test "a mobile's weight is the weight of its branches" do
    left = Branch.make(1, 1)
    right = Branch.make(2, 2)
    mobile = BinaryMobile.make(left, right)
    assert BinaryMobile.total_weight(mobile) == Branch.weight(left) + Branch.weight(right)
  end

  test "the weight of nested mobiles is computed correctly" do
    b1 = Branch.make(1, 1)
    b2 = Branch.make(2, 2)

    left_mobile = BinaryMobile.make(b1, b2)
    left = Branch.make(10, left_mobile)

    sub_mobile1 = BinaryMobile.make(b1, b1)
    sub_mobile2 = BinaryMobile.make(b2, b2)
    left_subbranch = Branch.make(5, sub_mobile1)
    right_subbranch = Branch.make(3, sub_mobile2)
    right_mobile = BinaryMobile.make(left_subbranch, right_subbranch)
    right = Branch.make(10, right_mobile)
    
    mobile = BinaryMobile.make(left, right)
    assert BinaryMobile.total_weight(mobile) == 3 * Branch.weight(b1) + 3 * Branch.weight(b2)
  end

  test "symmetric mobile is balanced" do
    b = Branch.make 1, 1
    mobile = BinaryMobile.make b, b
    assert BinaryMobile.balanced?(mobile)
  end

  test "asymmetric mobile is not balanced" do
    left = Branch.make 1, 1
    right = Branch.make 2, 2
    mobile = BinaryMobile.make left, right
    refute BinaryMobile.balanced?(mobile)
  end

  test "a mobile with branches of equal torque is balanced" do
    left = Branch.make 1, 4
    right = Branch.make 2, 2
    mobile = BinaryMobile.make left, right
    assert BinaryMobile.balanced? mobile
  end

  test "a mobile with balanced branches of equal torque is balanced" do
    b1 = Branch.make 1, 4
    b2 = Branch.make 2, 2
    left_mobile = BinaryMobile.make b1, b2
    left = Branch.make 10, left_mobile

    b3 = Branch.make 1, 8
    b4 = Branch.make 2, 4
    right_mobile = BinaryMobile.make b3, b4
    right = Branch.make 5, right_mobile

    mobile = BinaryMobile.make left, right
    assert BinaryMobile.balanced? mobile
  end
  
  test "a mobile with balanced branches of unequal torque is not balanced" do
    b1 = Branch.make 1, 4
    b2 = Branch.make 2, 2
    left_mobile = BinaryMobile.make b1, b2
    left = Branch.make 10, left_mobile

    b3 = Branch.make 1, 8
    b4 = Branch.make 2, 4
    right_mobile = BinaryMobile.make b3, b4
    right = Branch.make 10, right_mobile

    mobile = BinaryMobile.make left, right
    refute BinaryMobile.balanced? mobile
  end
  
  test "a mobile with unbalanced branches of equal torque is not balanced" do
    b1 = Branch.make 1, 4
    b2 = Branch.make 1, 2
    left_mobile = BinaryMobile.make b1, b2
    left = Branch.make 10, left_mobile

    b3 = Branch.make 1, 8
    b4 = Branch.make 2, 4
    right_mobile = BinaryMobile.make b3, b4
    right = Branch.make 5, right_mobile

    mobile = BinaryMobile.make left, right
    refute BinaryMobile.balanced? mobile
  end
  
  test "a mobile with unbalanced branches of unequal weight is not balanced" do
    b1 = Branch.make 1, 4
    b2 = Branch.make 1, 2
    left_mobile = BinaryMobile.make b1, b2
    left = Branch.make 10, left_mobile

    b3 = Branch.make 1, 8
    b4 = Branch.make 2, 4
    right_mobile = BinaryMobile.make b3, b4
    right = Branch.make 10, right_mobile

    mobile = BinaryMobile.make left, right
    refute BinaryMobile.balanced? mobile
  end
end
