# Bank class represents a bank
class Bank
    attr_reader :name, :accounts
  
    def initialize(name)
      @name = name
      @accounts = []
    end
  
    def open_account(owner, initial_balance)
      account = Account.new(owner, initial_balance)
      @accounts << account
      account
    end
  
    def close_account(account)
      @accounts.delete(account)
    end
  end
  
  # Account class represents a bank account
  class Account
    attr_reader :owner, :balance
  
    def initialize(owner, initial_balance)
      @owner = owner
      @balance = initial_balance
    end
  
    def deposit(amount)
      @balance += amount
    end
  
    def withdraw(amount)
      if amount <= @balance
        @balance -= amount
      else
        puts "Insufficient funds."
      end
    end
  end
  
  # Transaction class represents a financial transaction
  class Transaction
    attr_reader :source_account, :destination_account, :amount
  
    def initialize(source_account, destination_account, amount)
      @source_account = source_account
      @destination_account = destination_account
      @amount = amount
    end
  
    def execute
      if @source_account.balance >= @amount
        @source_account.withdraw(@amount)
        @destination_account.deposit(@amount)
        true
      else
        false
      end
    end
  end
  