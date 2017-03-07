def configure_money
  RateExchange::Money.conversion_rates('EUR', {
      'USD' => 1.11,
      'Bitcoin' => 0.0047
  })
end
