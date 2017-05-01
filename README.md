Plane Representation

```
        Lane1        Lane2       Lane3    Lane4
      C1 C2 C3   C1 C2 C3 C4    C1 C2   C1 C2 C3
Row1   1  2  3    1  2  3  4     1  2    1  2  3

Row2   4  5  6    5  6  7  8     3  4    4  5  6

Row3              9 10 11 12     5  6    7  8  9

Row4                                    10 11 12


```

# Steps to setup
- Go inside the project directory
- Run `bundle`
- Run `rake db:create`
- Run `rake db:migrate`
- Run `rails s`
- Type `localhost:3000` in your browser
