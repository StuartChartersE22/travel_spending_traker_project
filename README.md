# Travel Spending Tracker
Full stack web app using Ruby for logic and data handling, PostgreSQL for database persistance and querying, and Sinatra for browser interfacing with CSS styling. The app is designed for a single user to track the money they have spent or lent on a trip. It has the option to tag and itemise transactions as well as delcare them as business expenses. Also the user can track money lent to people whilst on the trip either through specific transactions or creating general lending transactions.

Further work:
Basic formatting has been implamented to get the pages to a readable format but more styling would be nice. Currently a bug where deleting a person doesn't delete any general lending transactions associated with them. Some delete functionality needed from the transaction side. Possible restructure of the transaction and lending relationship to inherit from a super class but a transaction to have a many to many relationship with people that have borrowed, and a lending just having a one to many relationship with its associated person that has borrowed.
