#lang

(require racket)
(require interactive-brokers-api)

(define ibkr (new ibkr-session% [port-no 7496]))


