class Transfer
  attr_accessor :sender, :receiver, :amount, :status
  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = "pending"
  end

  def valid?
    self.sender.valid? && self.receiver.valid?
  end

  def execute_transaction
    if self.status != "complete"
      sender.balance -= self.amount if self.sender.valid?
      if sender.valid?
        receiver.balance += self.amount if self.receiver.valid?
        self.status = "complete"
      else
        self.status = "rejected"
        return "Transaction rejected. Please check your account balance."
      end
    end
  end

  def reverse_transfer
    if status == "complete"
      sender.balance += self.amount if self.sender.valid?
      receiver.balance -= self.amount if self.receiver.valid?
      self.status = "reversed"
    end
  end

end
