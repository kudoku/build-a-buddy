# README


Start: 06/11 23:00
End: 06/13 00:30

I worked on this on and off but total time spent is about 4.5 hours. I would probably need another few hours or so to complete with tests and cleanup/refactor.

For the database design, I decided to encapsulate some of the business logic in the product/accessory data associations. Same goes for order items representing a "set" ie. a bear + associated accessories, which helps track price, and the algorithms below.

The majority of time was spent with the csv data import as I assumed that I couldn't modify the csv files, and as a result probably spent far too long trying to make it dynamic. If I could modify the csv files to a better format, the time would have been shortened considerably. The code is coupled tightly to the files, and I beleive it would have been best to require a standardized csv format for importing.

As for the algorithms section, I decided to use a different table to track product suggestions as a query on past orders would both take longer and be more complex. I was approaching the time limit so the code's logic exists but might contain small logic errors/shortcomings.

