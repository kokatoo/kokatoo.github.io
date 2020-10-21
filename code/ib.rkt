#lang racket

(require racket
         interactive-brokers-api)

(define ibkr (new ibkr-session%
                  [port-no 7496]
                  [write-messages #t]))
(send ibkr connect)

(require interactive-brokers-api/request-messages)

(send ibkr send-msg
      (new contract-details-req% [symbol "AAPL"]
           [security-type 'stk]))

(send ibkr send-msg (new historical-data-req%
                         [request-id 23]
                         [symbol "AAPL"]
                         [security-type 'stk]
                         [exchange "SMART"]
                         [duration (days 1)]))


(require gregor
         gregor/period)

