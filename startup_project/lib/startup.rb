require "employee"

class Startup
    attr_reader :name, :funding, :salaries, :employees
    
    def initialize(name, funding, salaries)
        @name = name
        @funding = funding
        @salaries = salaries
        @employees = []
    end

    def valid_title?(title)
        @salaries.has_key?(title)
    end

    def >(startup_2)
        self.funding > startup_2.funding
    end

    def hire(employee_name, title)
        if valid_title?(title)
            @employees << Employee.new(employee_name, title)
        else
            raise ArgumentError.new "Title is invalid" 
        end
    end

    def size
        @employees.length
    end

    def pay_employee(employee)
        amount = @salaries[employee.title]
        if @funding > amount
            employee.pay(amount)
            @funding -= amount
        else
            raise ArgumentError.new "Not enough funding to pay employee"
        end
    end

    def payday
        @employees.each { |employee| pay_employee(employee) }
    end

    def average_salary
        total = 0
        @employees.each { |employee| total += @salaries[employee.title] }
        total / @employees.length
    end

    def close
        @employees.clear
        @funding = 0
    end

    def acquire(startup_2)
        @funding += startup_2.funding

        new_salaries = startup_2.salaries
        new_salaries.each do |k, v|
            if !@salaries.has_key?(k)
                @salaries[k] = v
            end
        end

        startup_2.employees.each { |employee| @employees << employee }

        startup_2.close
    end
end
