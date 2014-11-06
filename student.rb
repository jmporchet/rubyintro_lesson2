class Student

  def initialize name, grade
    @name = name
    @grade = grade
  end

  def better_grade_than? other_student
    @grade > other_student.get_grade
  end

  protected

  def get_grade
    @grade
  end

end

joe = Student.new 'Joe', 18
bob = Student.new 'Bob', 1


puts "Well done!" if joe.better_grade_than?(bob)