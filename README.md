
CurrencyTracker
===============

CurrencyTracker allows you to track your personal collection of world currencies, by tagging the countries that you've visited along your travels.

Setup
-----

Seed the database with currencies and countries by running:

```bash
rake db:seed
```

Testing
-------

Run all test with:

```bash
bundle exec rake travis
```

Run unit tests with:

```bash
bundle exec rake test
```

Cucumber features can be run with:

```bash
bundle exec rake cucumber
```

Features
--------

* Track Visited Countries
* Track Collected Currencies
* Charts show you how far along you are!

Realization Notes
-----------------

1. Scope Country.with_visits_data_for use raw sql to prevent 1+n queries on Country.visited_by?(user) calls
2. As far, as we don't use paging, we can filter data on client-side
