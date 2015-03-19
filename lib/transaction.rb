class Transaction
  attr_reader(
    :id,
    :invoice_id,
    :credit_card_number,
    :credit_card_expiration_date,
    :result,
    :created_at,
    :updated_at,
    :repo
  )

  def initialize(
    id,
    invoice_id,
    credit_card_number,
    credit_card_expiration_date,
    result,
    created_at,
    updated_at,
    repo
  )

    @id                      = id.to_i
    @invoice_id              = invoice_id.to_i
    @credit_card_number      = credit_card_number
    @credit_card_expiration  = credit_card_expiration_date
    @result                  = result
    @created_at              = created_at
    @updated_at              = updated_at
    @repo                    = repo
  end

  def invoice
    repo.find_invoice(invoice_id)
  end
end
