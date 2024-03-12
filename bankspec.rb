require_relative 'bank'

RSpec.describe Bank do
  describe "#open_account" do
    it "creates a new account and adds it to the bank's accounts" do
      bank = Bank.new("Example Bank")
      account = bank.open_account("John Doe", 100)
      expect(bank.accounts).to include(account)
    end
  end

  describe "#close_account" do
    it "removes the specified account from the bank's accounts" do
      bank = Bank.new("Example Bank")
      account = bank.open_account("John Doe", 100)
      bank.close_account(account)
      expect(bank.accounts).not_to include(account)
    end
  end
end

RSpec.describe Account do
  describe "#deposit" do
    it "increases the account balance by the deposited amount" do
      account = Account.new("John Doe", 100)
      account.deposit(50)
      expect(account.balance).to eq(150)
    end
  end

  describe "#withdraw" do
    context "when sufficient funds are available" do
      it "decreases the account balance by the withdrawn amount" do
        account = Account.new("John Doe", 100)
        account.withdraw(50)
        expect(account.balance).to eq(50)
      end
    end

    context "when insufficient funds are available" do
      it "does not change the account balance" do
        account = Account.new("John Doe", 100)
        account.withdraw(150)
        expect(account.balance).to eq(100)
      end
    end
  end
end

RSpec.describe Transaction do
  describe "#execute" do
    context "when source account has sufficient funds" do
      it "transfers money from source to destination account" do
        source_account = Account.new("John Doe", 200)
        destination_account = Account.new("Jane Doe", 100)
        transaction = Transaction.new(source_account, destination_account, 50)
        transaction.execute
        expect(source_account.balance).to eq(150)
        expect(destination_account.balance).to eq(150)
      end
    end

    context "when source account has insufficient funds" do
      it "does not transfer money and returns false" do
        source_account = Account.new("John Doe", 50)
        destination_account = Account.new("Jane Doe", 100)
        transaction = Transaction.new(source_account, destination_account, 100)
        result = transaction.execute
        expect(result).to be_falsey
        expect(source_account.balance).to eq(50)
        expect(destination_account.balance).to eq(100)
      end
    end
  end
end
