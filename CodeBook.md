How it works

=======

Steps:

  1. Loads the X&Y train and X&Y test files into data frames
  2. Merges them with rbind
  3. Read Subjects train and test
  4. Only keeps the features that contain "mean" or "std"
  5. Finally, transforms the data into the intended final form with melt and dcast
  6. The names of the measures are as columns

