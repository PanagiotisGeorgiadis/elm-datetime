module DateTime.Clock exposing
    ( RawTime, Time, Hour, Minute, Second, Millisecond
    , fromRawParts, fromPosix
    , toMillis, hoursToInt, minutesToInt, secondsToInt, millisecondsToInt
    , getHours, getMinutes, getSeconds, getMilliseconds
    , incrementHours, incrementMinutes, incrementSeconds, incrementMilliseconds
    , decrementHours, decrementMinutes, decrementSeconds, decrementMilliseconds
    , compareTime, compareHours, compareMinutes, compareSeconds, compareMilliseconds
    , zero
    )

{-| A clock time.


# Type definition

@docs RawTime, Time, Hour, Minute, Second, Millisecond


# Creating values

@docs fromRawParts, fromPosix


# Conversions

@docs toMillis, hoursToInt, minutesToInt, secondsToInt, millisecondsToInt


# Getters

@docs getHours, getMinutes, getSeconds, getMilliseconds


# Incrementers

@docs incrementHours, incrementMinutes, incrementSeconds, incrementMilliseconds


# Decrementers

@docs decrementHours, decrementMinutes, decrementSeconds, decrementMilliseconds


# Comparers

@docs compareTime, compareHours, compareMinutes, compareSeconds, compareMilliseconds


# Constants

@docs zero

-}

import DateTime.Clock.Internal as Internal
import Time as Time_


{-| A clock time.
-}
type alias Time =
    Internal.Time


type alias Hour =
    Internal.Hour


type alias Minute =
    Internal.Minute


type alias Second =
    Internal.Second


type alias Millisecond =
    Internal.Millisecond


{-| An 'abstract' representation of Time and its constituent parts based on Integers.
-}
type alias RawTime =
    Internal.RawTime


{-| Construct a clock `Time` from raw hour, minute, second, millisecond integers.

> fromRawParts { hours = 12, minutes = 30, seconds = 0, milliseconds = 0 }
> Just (Time { hours = Hours 12, minutes = Minutes 30, seconds = Second 0, milliseconds = Millisecond 0 }) : Maybe Time
>
> fromRawParts { hours = 12, minutes = 60, seconds = 0, milliseconds = 0 }
> Nothing : Maybe Time

-}
fromRawParts : RawTime -> Maybe Time
fromRawParts =
    Internal.fromRawParts


{-| Attempt to construct a `Hour` from an `Int`.

> hoursFromInt 3
> Just (Hour 3) : Maybe Hour
> hoursFromInt 45
> Just (Hour 45) : Maybe Hour
> hoursFromInt 75
> Nothing : Maybe Hour

-- Internal use only

-}
hoursFromInt : Int -> Maybe Hour
hoursFromInt =
    Internal.hoursFromInt


{-| Attempt to construct a `Minute` from an `Int`.

> minutesFromInt 3
> Just (Minute 3) : Maybe Minute
> minutesFromInt 45
> Just (Minute 45) : Maybe Minute
> minutesFromInt 75
> Nothing : Maybe Minute

-- Internal use only

-}
minutesFromInt : Int -> Maybe Minute
minutesFromInt =
    Internal.minutesFromInt


{-| Attempt to construct a `Second` from an `Int`.

> secondsFromInt 3
> Just (Second 3) : Maybe Second
> secondsFromInt 45
> Just (Second 45) : Maybe Second
> secondsFromInt 75
> Nothing : Maybe Second

-- Internal use only

-}
secondsFromInt : Int -> Maybe Second
secondsFromInt =
    Internal.secondsFromInt


{-| Attempt to construct a `Millisecond` from an `Int`.

> millisecondsFromInt 300
> Just (Millisecond 300) : Maybe Millisecond
> millisecondsFromInt 450
> Just (Millisecond 450) : Maybe Millisecond
> millisecondsFromInt 1500
> Nothing : Maybe Millisecond

-- Internal use only

-}
millisecondsFromInt : Int -> Maybe Millisecond
millisecondsFromInt =
    Internal.millisecondsFromInt


{-| Get a clock `Time` from a time zone and posix time.

> fromPosix (Time.millisToPosix 0)
> { hour = Hour 0, minute = Minute 0, second = Second 0, millisecond = 0 } : Time
>
> fromPosix (Time.millisToPosix 1545328255284)
> { hour = Hour 17, minute = Minute 50, second = Second 55, millisecond = Millisecond 284 }

-}
fromPosix : Time_.Posix -> Time
fromPosix =
    Internal.fromPosix


{-| Convert a `Time` to milliseconds.

> Maybe.map toMillis (fromRawParts { hours = 12, minutes = 30, seconds = 0, milliseconds = 0 })
> Just 45000000 : Maybe Int

-}
toMillis : Time -> Int
toMillis =
    Internal.toMillis


{-| Convert an `Hour` to an `Int`.

> Maybe.map hoursToInt (hoursFromInt 12)
> Just 12 : Maybe Int

-- I Think it should be internal because the consumer should never have
-- "Hour" in their model. The exposed one should be, getHours

-}
hoursToInt : Hour -> Int
hoursToInt =
    Internal.hoursToInt


{-| Convert a `Minute` to an `Int`.

> Maybe.map minutesToInt (minutesFromInt 30)
> Just 30 : Maybe Int

-- I Think it should be internal because the consumer should never have
-- "Minute" in their model. The exposed one should be, getMinutes

-}
minutesToInt : Minute -> Int
minutesToInt =
    Internal.minutesToInt


{-| Convert a `Second` to an `Int`.

> Maybe.map secondsToInt (secondsFromInt 30)
> Just 30 : Maybe Int

-- I Think it should be internal because the consumer should never have
-- "Second" in their model. The exposed one should be, getSeconds

-}
secondsToInt : Second -> Int
secondsToInt =
    Internal.secondsToInt


{-| Convert a `Millisecond` to an `Int`.

> Maybe.map millisecondsToInt (millisecondsFromInt 500)
> Just 500 : Maybe Int

-- I Think it should be internal because the consumer should never have
-- "Millisecond" in their model. The exposed one should be, getMilliseconds

-}
millisecondsToInt : Millisecond -> Int
millisecondsToInt =
    Internal.millisecondsToInt


{-| Returns the 'Hour' portion of a 'Time'
-}
getHours : Time -> Hour
getHours =
    Internal.getHours


{-| Returns the 'Minute' portion of a 'Time'
-}
getMinutes : Time -> Minute
getMinutes =
    Internal.getMinutes


{-| Returns the 'Second' portion of a 'Time'
-}
getSeconds : Time -> Second
getSeconds =
    Internal.getSeconds


{-| Returns the 'Millisecond' portion of a 'Time'
-}
getMilliseconds : Time -> Millisecond
getMilliseconds =
    Internal.getMilliseconds


{-| Increments an 'Hour' inside a 'Time'.

> time = fromRawParts { hours = 12, minutes = 15, seconds = 0, milliseconds = 0 }
> Maybe.map incrementHours time
> Just (Time { hours = Hour 13, minutes = Minute 15, seconds = Second 0, milliseconds = Millisecond 0 }, False) : Maybe (Time, Bool)

> time2 = fromRawParts { hours 23, minutes = 0, seconds = 0, milliseconds = 0 }
> Maybe.map incrementHours time2
> Just (Time { hours = Hour 0, minutes = Minute 0, seconds = Second 0, milliseconds = Millisecond 0}, True) : Maybe (Time, Bool)

--- The Time will keep on cycling around from 23:00 to 00:00 because it has
--- no knowledge of the 'Calendar' concept. It will also be returning a Bool
--- which is used in order to indicate if there has been a full cycle on the day.
--- The DateTime component will be accountable for changes in the calendar
--- when that is necessary.

-}
incrementHours : Time -> ( Time, Bool )
incrementHours =
    Internal.incrementHours


{-| Increments a 'Minute' inside a 'Time'.

> time = fromRawParts { hours = 12, minutes = 15, seconds = 0, milliseconds = 0 }
> Maybe.map incrementMinutes time
> Just (Time { hours = Hours 12, minutes = Minute 16, seconds = Second 0, milliseconds = Millisecond 0 }, False) : Maybe (Time, Bool)
>
> time2 = fromRawParts { hours = 23, minutes = 59, seconds = 0, milliseconds = 0 }
> Maybe.map incrementMinutes time2
> Just (Time { hours = Hours 0, minutes = Minute 0, seconds = Second 0, milliseconds = Millisecond 0 }, True) : Maybe (Time, Bool)

-}
incrementMinutes : Time -> ( Time, Bool )
incrementMinutes =
    Internal.incrementMinutes


{-| Increments a 'Second' inside a 'Time'.

> time = fromRawParts { hours = 12, minutes = 15, seconds = 0, milliseconds = 0 }
> Maybe.map incrementSeconds time
> Just (Time { hours = Hour 12, minutes = Minute 15, seconds = Second 1, milliseconds = Millisecond 0 }, False) : Maybe (Time, Bool)
>
> time2 = fromRawParts { hours = 23, minutes = 59, seconds = 59, milliseconds = 0 }
> Maybe.map incrementSeconds time2
> Just (Time { hours = Hours 0, minutes = Minute 0, seconds = Second 0, milliseconds = Millisecond 0 }, True) : Maybe (Time, Bool)

-}
incrementSeconds : Time -> ( Time, Bool )
incrementSeconds =
    Internal.incrementSeconds


{-| Increments a 'Millisecond' inside a 'Time'.

> time = fromRawParts { hours = 12, minutes = 15, seconds = 0, milliseconds = 0 }
> Maybe.map incrementMilliseconds time
> Just (Time { hours = Hour 12, minutes = Minute 15, seconds = Second 0, milliseconds = Millisecond 1 }, False) : Maybe (Time, Bool)
>
> time2 = fromRawParts { hours = 23, minutes = 59, seconds = 59, milliseconds = 999 }
> Maybe.map incrementMilliseconds time
> Just (Time { hours = Hours 0, minutes = Minute 0, seconds = Second 0, milliseconds = Millisecond 0 }, True) : Maybe (Time, Bool)

-}
incrementMilliseconds : Time -> ( Time, Bool )
incrementMilliseconds =
    Internal.incrementMilliseconds


{-| Decrements an 'Hour' inside a 'Time'.

> time = fromRawParts { hours = 12, minutes = 15, seconds = 0, milliseconds = 0 }
> Maybe.map decrementHours time
> Just (Time { hours = Hour 11, minutes = Minute 15, seconds = Second 0, milliseconds = Millisecond 0 }, False) : Maybe (Time, Bool)

> time2 = fromRawParts { hours 0, minutes = 0, seconds = 0, milliseconds = 0 }
> Maybe.map decrementHours time2
> Just (Time { hours = Hour 23, minutes = Minute 0, seconds = Second 0, milliseconds = Millisecond 0}, True) : Maybe (Time, Bool)

--- The Time will keep on cycling around from 00:00 to 23:00 because it has
--- no knowledge of the 'Calendar' concept. It will also be returning a Bool
--- which is used in order to indicate if there has been a full cycle on the day.
--- The DateTime component will be accountable for changes in the calendar
--- when that is necessary.

-}
decrementHours : Time -> ( Time, Bool )
decrementHours =
    Internal.decrementHours


{-| Decrements a 'Minute' inside a 'Time'.

> time = fromRawParts { hours = 12, minutes = 15, seconds = 0, milliseconds = 0 }
> Maybe.map decrementMinutes time
> Just (Time { hours = Hours 12, minutes = Minute 14, seconds = Second 0, milliseconds = Millisecond 0 }, False) : Maybe (Time, Bool)
>
> time2 = fromRawParts { hours = 0, minutes = 0, seconds = 0, milliseconds = 0 }
> Maybe.map decrementMinutes time2
> Just (Time { hours = Hours 23, minutes = Minute 59, seconds = Second 0, milliseconds = Millisecond 0 }, True) : Maybe (Time, Bool)

-}
decrementMinutes : Time -> ( Time, Bool )
decrementMinutes =
    Internal.decrementMinutes


{-| Decrements a 'Second' inside a 'Time'.

> time = fromRawParts { hours = 12, minutes = 15, seconds = 30, milliseconds = 0 }
> Maybe.map decrementSeconds time
> Just (Time { hours = Hour 12, minutes = Minute 15, seconds = Second 29, milliseconds = Millisecond 0 }, False) : Maybe (Time, Bool)
>
> time2 = fromRawParts { hours = 0, minutes = 0, seconds = 0, milliseconds = 0 }
> Maybe.map decrementSeconds time2
> Just (Time { hours = Hours 23, minutes = Minute 59, seconds = Second 59, milliseconds = Millisecond 0 }, True) : Maybe (Time, Bool)

-}
decrementSeconds : Time -> ( Time, Bool )
decrementSeconds =
    Internal.decrementSeconds


{-| Decrements a 'Millisecond' inside a 'Time'.

> time = fromRawParts { hours = 12, minutes = 15, seconds = 0, milliseconds = 500 }
> Maybe.map decrementMilliseconds time
> Just (Time { hours = Hour 12, minutes = Minute 15, seconds = Second 0, milliseconds = Millisecond 499 }, False) : Maybe (Time, Bool)
>
> time2 = fromRawParts { hours = 0, minutes = 0, seconds = 0, milliseconds = 0 }
> Maybe.map decrementMilliseconds time
> Just (Time { hours = Hours 23, minutes = Minute 59, seconds = Second 59, milliseconds = Millisecond 999 }, True) : Maybe (Time, Bool)

-}
decrementMilliseconds : Time -> ( Time, Bool )
decrementMilliseconds =
    Internal.decrementMilliseconds


{-| Compare two `Time` values.

> time = fromRawParts { hours = 12, minutes = 15, seconds = 0, milliseconds = 0 }
> time2 = fromRawParts { hours = 12, minutes = 20, seconds = 0, milliseconds = 0 }
> Maybe.map2 compareHours time time2
> LT : Order

-}
compareTime : Time -> Time -> Order
compareTime lhs rhs =
    Internal.compareTime lhs rhs


{-| Compare two `Hour` values.

> Maybe.map2 compareHours (hoursFromInt 10) (hoursFromInt 6)
> LT : Order

-- I think it could be internal use only because we don't want the consumer to
-- have any notion of 'Hour'.

-- Internal use only

-}
compareHours : Hour -> Hour -> Order
compareHours lhs rhs =
    Internal.compareHours lhs rhs


{-| Compare two `Minute` values.

> Maybe.map2 compareMilliseconds (minutesFromInt 15) (minutesFromInt 15)
> EQ : Order

-- I think it could be internal use only because we don't want the consumer to
-- have any notion of 'Hour'.

-- Internal use only

-}
compareMinutes : Minute -> Minute -> Order
compareMinutes lhs rhs =
    Internal.compareMinutes lhs rhs


{-| Compare two `Second` values.

> Maybe.map2 compareSeconds (secondsFromInt 30) (secondsFromInt 45)
> LT : Order

-- I think it could be internal use only because we don't want the consumer to
-- have any notion of 'Hour'.

-- Internal use only

-}
compareSeconds : Second -> Second -> Order
compareSeconds lhs rhs =
    Internal.compareSeconds lhs rhs


{-| Compare two `Millisecond` values.

> Maybe.map2 compareMilliseconds (millisecondsFromInt 200) (millisecondsFromInt 200)
> EQ : Order

-- I think it could be internal use only because we don't want the consumer to
-- have any notion of 'Hour'.

-- Internal use only

-}
compareMilliseconds : Millisecond -> Millisecond -> Order
compareMilliseconds lhs rhs =
    Internal.compareMilliseconds lhs rhs


{-| Returns a zero time. To be used with caution.
-}
zero : Time
zero =
    Internal.zero
