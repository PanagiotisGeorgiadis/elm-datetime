module DateTime exposing
    ( DateTime
    , fromPosix, fromRawParts, fromDateAndTime
    , toPosix, toMillis
    , getDate, getTime, getYear, getMonth, getDay, getHours, getMinutes, getSeconds, getMilliseconds
    , setDate, setTime, setYear, setMonth, setDay, setHours, setMinutes, setSeconds, setMilliseconds
    , incrementYear, incrementMonth, incrementDay, incrementHours, incrementMinutes, incrementSeconds, incrementMilliseconds
    , decrementYear, decrementMonth, decrementDay, decrementHours, decrementMinutes, decrementSeconds, decrementMilliseconds
    , compare, compareDates, compareTime
    , getTimezoneOffset, getDateRange, getDatesInMonth, getDayDiff, getWeekday, isLeapYear, lastDayOf, sort
    )

{-| The [DateTime](DateTime#) module was introduced in order to keep track of both the
[Date](Calendar#Date) and [Time](Clock#Time). The `DateTime`
consists of a `Day`, `Month`, `Year`, `Hours`, `Minutes`, `Seconds` and `Milliseconds`.
You can construct a `DateTime` either by using a [Posix](https://package.elm-lang.org/packages/elm/time/latest/Time#Posix)
or by using an existing [Date](Calendar#Date) and [Time](Clock#Time) combination. Otherwise
you can _**attempt**_ to construct a `DateTime` by using a combination of a
[RawDate](Calendar#RawDate) and a [RawClock](Clock#RawClock).

@docs DateTime


# Creating a `DateTime`

@docs fromPosix, fromRawParts, fromDateAndTime


# Conversions

@docs toPosix, toMillis


# Accessors

@docs getDate, getTime, getYear, getMonth, getDay, getHours, getMinutes, getSeconds, getMilliseconds


# Setters

@docs setDate, setTime, setYear, setMonth, setDay, setHours, setMinutes, setSeconds, setMilliseconds


# Increment values

@docs incrementYear, incrementMonth, incrementDay, incrementHours, incrementMinutes, incrementSeconds, incrementMilliseconds


# Decrement values

@docs decrementYear, decrementMonth, decrementDay, decrementHours, decrementMinutes, decrementSeconds, decrementMilliseconds


# Compare values

@docs compare, compareDates, compareTime


# Utilities

@docs getTimezoneOffset, getDateRange, getDatesInMonth, getDayDiff, getWeekday, isLeapYear, lastDayOf, sort

-}

import Calendar as Calendar
import Clock as Clock
import DateTime.Internal as Internal
import Time


{-| An instant in time, composed of a [Date](Calendar#Date) and a [Time](Clock#Time).
-}
type alias DateTime =
    Internal.DateTime



-- Creating a `DateTime`


{-| Create a `DateTime` from a [Posix](https://package.elm-lang.org/packages/elm/time/latest/Time#Posix) time.

    fromPosix (Time.millisToPosix 0)
    -- DateTime { date = Date { day = Day 1, month = Jan, year = Year 1970 }, time = Time { hours = Hour 0, minutes = Minute 0, seconds = Second 0, milliseconds = Millisecond 0 } } : DateTime

    fromPosix (Time.millisToPosix 1566795954000)
    -- DateTime { date = Date { day = Day 26, month = Aug, year = Year 2019 }, time = Time { hours = Hour 5, minutes = Minute 5, seconds = Second 54, milliseconds = Millisecond 0 } } : DateTime

-}
fromPosix : Time.Posix -> DateTime
fromPosix =
    Internal.fromPosix


{-| Attempts to construct a new `DateTime` object from its raw constituent parts. Returns `Nothing` if
any parts or their combination would result in an invalid [DateTime](DateTime#DateTime).

    fromRawParts { day = 26, month = Aug, year = 2019 } { hours = 12, minutes = 30, seconds = 45, milliseconds = 0 }
    -- Just (DateTime { date = Date { day = Day 26, month = Aug, year = Year 2019 }, time = Time { hours = Hour 12, minutes = Minute 30, seconds = Second 45, milliseconds = Millisecond 0 }}) : Maybe DateTime

    fromRawParts { day = 29, month = Feb, year = 2019 } { hours = 16, minutes = 30, seconds = 45, milliseconds = 0 }
    -- Nothing : Maybe DateTime

    fromRawParts { day = 15, month = Nov, year = 2019 } { hours = 24, minutes = 20, seconds = 40, milliseconds = 0 }
    -- Nothing : Maybe DateTime

-}
fromRawParts : Calendar.RawDate -> Clock.RawTime -> Maybe DateTime
fromRawParts rawDate rawTime =
    Internal.fromRawParts rawDate rawTime


{-| Create a [DateTime](DateTime#DateTime) by combining a [Date](Calendar#Date) and [Time](Clock#Time).

    -- date == 26 Aug 2019
    -- time == 12:30:45.000

    fromDateAndTime date time
    -- DateTime { date = Date { day = Day 26, month = Aug, year = Year 2019 }, time = Time { hours = Hour 12, minutes = Minute 30, seconds = Second 45, milliseconds = Millisecond 0 } } : DateTime

-}
fromDateAndTime : Calendar.Date -> Clock.Time -> DateTime
fromDateAndTime =
    Internal.fromDateAndTime



-- Conversions


{-| Converts a `DateTime` to a posix time. The result is relative to the [Epoch](https://en.wikipedia.org/wiki/Unix_time).
This basically means that **if the DateTime provided is after the Epoch** the result will be a **positive posix time.** Otherwise the
result will be a **negative posix time**.

    -- dateTime  == 25 Dec 2019 19:23:45.000
    toPosix dateTime -- Posix 1577301825000 : Posix

    -- dateTime2 == 1 Jan 1970 00:00:00.000 : Posix
    toPosix dateTime2 -- Posix 0

    -- dateTime3 == 8 Jan 1920 04:36:15.000
    toPosix dateTime3 -- Posix -1577301825000 : Posix

-}
toPosix : DateTime -> Time.Posix
toPosix =
    Internal.toPosix


{-| Convers a `DateTime` to the equivalent milliseconds. The result is relative to the [Epoch](https://en.wikipedia.org/wiki/Unix_time).
This basically means that **if the DateTime provided is after the Epoch** the result will be a **positive number** representing the milliseconds
that have elapsed since the Epoch. Otherwise the result will be a negative number representing the milliseconds required in order to reach the Epoch.

    -- dateTime  == 25 Dec 2019 19:23:45.000
    toMillis dateTime -- 1577301825000 : Int

    -- dateTime2 == 1 Jan 1970 00:00:00.000
    toMillis dateTime2 -- 0 : Int

    -- dateTime3 == 8 Jan 1920 04:36:15.000
    toMillis dateTime3 -- -1577301825000 : Int

-}
toMillis : DateTime -> Int
toMillis =
    Internal.toMillis



-- Accessors


{-| Extract the [Date](Calendar#Date) from a `DateTime`.

    -- dateTime == 25 Dec 2019 16:45:30.000
    getDate dateTime -- 25 Dec 2019 : Calendar.Date

-}
getDate : DateTime -> Calendar.Date
getDate =
    Internal.getDate


{-| Extract the [Time](Clock#Time) from a `DateTime`.

    -- dateTime == 25 Dec 2019 16:45:30.000
    getTime dateTime -- 16:45:30.000 : Clock.Time

-}
getTime : DateTime -> Clock.Time
getTime =
    Internal.getTime


{-| Extract the `Year` part of a `DateTime` as an Int.

    -- dateTime == 25 Dec 2019 16:45:30.000
    getYear dateTime -- 2019 : Int

-}
getYear : DateTime -> Int
getYear =
    Internal.getYear


{-| Extract the `Month` part of a `DateTime` as a [Month](https://package.elm-lang.org/packages/elm/time/latest/Time#Month).

    -- dateTime == 25 Dec 2019 16:45:30.000
    getMonth dateTime -- Dec : Time.Month

-}
getMonth : DateTime -> Time.Month
getMonth =
    Internal.getMonth


{-| Extract the `Day` part of `DateTime` as an Int.

    -- dateTime == 25 Dec 2019 16:45:30.000
    getDay dateTime -- 25 : Int

-}
getDay : DateTime -> Int
getDay =
    Internal.getDay


{-| Extract the `Hour` part of `DateTime` as an Int.

    -- dateTime == 25 Dec 2019 16:45:30.000
    getHours dateTime -- 16 : Int

-}
getHours : DateTime -> Int
getHours =
    Internal.getHours


{-| Extract the `Minute` part of `DateTime` as an Int.

    -- dateTime == 25 Dec 2019 16:45:30.000
    getMinutes dateTime -- 45 : Int

-}
getMinutes : DateTime -> Int
getMinutes =
    Internal.getMinutes


{-| Extract the `Second` part of `DateTime` as an Int.

    -- dateTime == 25 Dec 2019 16:45:30.000
    getSeconds dateTime -- 30 : Int

-}
getSeconds : DateTime -> Int
getSeconds =
    Internal.getSeconds


{-| Extract the `Millisecond` part of `DateTime` as an Int.

    -- dateTime == 25 Dec 2019 16:45:30.000
    getMilliseconds dateTime -- 0 : Int

-}
getMilliseconds : DateTime -> Int
getMilliseconds =
    Internal.getMilliseconds



-- Setters


{-| Sets the `Date` part of a [DateTime#DateTime].

    -- date == 26 Aug 2019
    -- dateTime == 25 Dec 2019 16:45:30.000
    setDate date dateTime -- 26 Aug 2019 16:45:30.000

-}
setDate : Calendar.Date -> DateTime -> DateTime
setDate =
    Internal.setDate


{-| Sets the `Time` part of a [DateTime#DateTime].

    -- dateTime == 25 Dec 2019 16:45:30.000
    setTime Clock.midnight dateTime -- 25 Dec 2019 00:00:00.000

-}
setTime : Clock.Time -> DateTime -> DateTime
setTime =
    Internal.setTime


{-| Attempts to set the `Year` part of a [Calendar.Date](Calendar#Date) in a `DateTime`.

    -- dateTime == 29 Feb 2020 15:30:30.000
    setYear 2024 dateTime -- Just (29 Feb 2024 15:30:30.000) : Maybe DateTime

    setYear 2019 dateTime -- Nothing : Maybe DateTime

-}
setYear : Int -> DateTime -> Maybe DateTime
setYear =
    Internal.setYear


{-| Attempts to set the `Month` part of a [Calendar.Date](Calendar#Date) in a `DateTime`.

    -- dateTime == 31 Jan 2019 15:30:30.000
    setMonth Aug dateTime -- Just (31 Aug 2019 15:30:30.000) : Maybe DateTime

    setMonth Apr dateTime -- Nothing : Maybe DateTime

-}
setMonth : Time.Month -> DateTime -> Maybe DateTime
setMonth =
    Internal.setMonth


{-| Attempts to set the `Day` part of a [Calendar.Date](Calendar#Date) in a `DateTime`.

    -- dateTime == 31 Jan 2019 15:30:30.000
    setDay 25 dateTime -- Just (25 Jan 2019 15:30:30.000) : Maybe DateTime

    setDay 32 dateTime -- Nothing : Maybe DateTime

-}
setDay : Int -> DateTime -> Maybe DateTime
setDay =
    Internal.setDay


{-| Attempts to set the `Hours` part of a [Clock.Time](Clock#Time) in a DateTime.

    -- dateTime == 2 Jul 2019 12:00:00.000
    setHours 23 dateTime -- Just (2 Jul 2019 23:00:00.000) : Maybe DateTime

    setHours 24 dateTime -- Nothing : Maybe DateTime

-}
setHours : Int -> DateTime -> Maybe DateTime
setHours =
    Internal.setHours


{-| Attempts to set the `Minutes` part of a [Clock.Time](Clock#Time) in a DateTime.

    -- dateTime == 2 Jul 2019 12:00:00.000
    setMinutes 36 dateTime -- Just (2 Jul 2019 12:36:00.000) : Maybe DateTime

    setMinutes 60 dateTime -- Nothing : Maybe DateTime

-}
setMinutes : Int -> DateTime -> Maybe DateTime
setMinutes =
    Internal.setMinutes


{-| Attempts to set the `Seconds` part of a [Clock.Time](Clock#Time) in a DateTime.

    -- dateTime == 2 Jul 2019 12:00:00.000
    setSeconds 20 dateTime -- Just (2 Jul 2019 12:00:20.000) : Maybe DateTime

    setSeconds 60 dateTime -- Nothing : Maybe DateTime

-}
setSeconds : Int -> DateTime -> Maybe DateTime
setSeconds =
    Internal.setSeconds


{-| Attempts to set the `Milliseconds` part of a [Clock.Time](Clock#Time) in a DateTime.

    -- dateTime == 2 Jul 2019 12:00:00.000
    setMilliseconds 589 dateTime -- Just (2 Jul 2019 12:00:00.589) : Maybe DateTime

    setMilliseconds 1000 dateTime -- Nothing : Maybe DateTime

-}
setMilliseconds : Int -> DateTime -> Maybe DateTime
setMilliseconds =
    Internal.setMilliseconds



-- Increment values


{-| Increments the `Year` in a given [DateTime](DateTime#DateTime) while preserving the `Month`, and `Day` parts.
_The [Time](Clock#Time) related parts will remain the same._

    -- dateTime  == 31 Jan 2019 15:30:45.100
    incrementYear dateTime -- 31 Jan 2020 15:30:45.100 : DateTime

    -- dateTime2 == 29 Feb 2020 15:30:45.100
    incrementYear dateTime2 -- 28 Feb 2021 15:30:45.100 : DateTime

**Note:** In the first example, incrementing the `Year` causes no changes in the `Month` and `Day` parts.
On the second example we see that the `Day` part is different than the input. This is because the resulting date in the `DateTime`
would be an invalid date ( _**29th of February 2021**_ ). As a result of this scenario we fall back to the last valid day
of the given `Month` and `Year` combination.

-}
incrementYear : DateTime -> DateTime
incrementYear =
    Internal.incrementYear


{-| Increments the `Month` in a given [DateTime](DateTime#DateTime). It will also roll over to the next year where applicable.
_The [Time](Clock#Time) related parts will remain the same._

    -- dateTime  == 15 Sep 2019 15:30:45.100
    incrementMonth dateTime -- 15 Oct 2019 15:30:45.100 : DateTime

    -- dateTime2 == 15 Dec 2019 15:30:45.100
    incrementMonth dateTime2 -- 15 Jan 2020 15:30:45.100 : DateTime

    -- dateTime3 == 30 Jan 2019 15:30:45.100
    incrementMonth dateTime3 -- 28 Feb 2019 15:30:45.100 : DateTime

**Note:** In the first example, incrementing the `Month` causes no changes in the `Year` and `Day` parts while on the second
example it rolls forward the 'Year'. On the last example we see that the `Day` part is different than the input. This is because
the resulting date would be an invalid one ( _**31st of February 2019**_ ). As a result of this scenario we fall back to the last
valid day of the given `Month` and `Year` combination.

-}
incrementMonth : DateTime -> DateTime
incrementMonth =
    Internal.incrementMonth


{-| Increments the `Day` in a given [DateTime](DateTime#DateTime). Will also increment `Month` and `Year` where applicable.

    -- dateTime  == 25 Aug 2019 15:30:45.100
    incrementDay dateTime -- 26 Aug 2019 15:30:45.100 : DateTime

    -- dateTime2 == 31 Dec 2019 15:30:45.100
    incrementDay dateTime2 -- 1 Jan 2020 15:30:45.100 : DateTime

-}
incrementDay : DateTime -> DateTime
incrementDay =
    Internal.incrementDay


{-| Increments the `Hours` in a given [DateTime](DateTime#DateTime). Will also increment `Day`, `Month`, `Year` where applicable.

    -- dateTime  == 25 Aug 2019 15:30:45.100
    incrementHours dateTime -- 25 Aug 2019 16:30:45.100 : DateTime

    -- dateTime2 == 31 Dec 2019 23:00:00.000
    incrementHours dateTime2 -- 1 Jan 2020 00:00:00.000 : DateTime

-}
incrementHours : DateTime -> DateTime
incrementHours =
    Internal.incrementHours


{-| Increments the `Minutes` in a given [DateTime](DateTime#DateTime). Will also increment `Hours`, `Day`, `Month`, `Year` where applicable.

    -- dateTime  == 25 Aug 2019 15:30:45.100
    incrementMinutes dateTime -- 25 Aug 2019 15:31:45.100 : DateTime

    -- dateTime2 == 31 Dec 2019 23:59:00.000
    incrementMinutes dateTime2 -- 1 Jan 2020 00:00:00.000 : DateTime

-}
incrementMinutes : DateTime -> DateTime
incrementMinutes =
    Internal.incrementMinutes


{-| Increments the `Seconds` in a given [DateTime](DateTime#DateTime). Will also increment `Minutes`, `Hours`, `Day`, `Month`, `Year` where applicable.

    -- dateTime  == 25 Aug 2019 15:30:45.100
    incrementSeconds dateTime -- 25 Aug 2019 15:30:46.100 : DateTime

    -- dateTime2 == 31 Dec 2019 23:59:59.000
    incrementSeconds dateTime2 -- 1 Jan 2020 00:00:00.000 : DateTime

-}
incrementSeconds : DateTime -> DateTime
incrementSeconds =
    Internal.incrementSeconds


{-| Increments the `Milliseconds` in a given [DateTime](DateTime#DateTime). Will also increment `Seconds`, `Minutes`, `Hours`, `Day`, `Month`, `Year` where applicable.

    -- dateTime  == 25 Aug 2019 15:30:45.100
    incrementMilliseconds dateTime -- 25 Aug 2019 15:30:45:101 : DateTime

    -- dateTime2 == 31 Dec 2019 23:59:59.999
    incrementMilliseconds dateTime2 -- 1 Jan 2020 00:00:00.000 : DateTime

-}
incrementMilliseconds : DateTime -> DateTime
incrementMilliseconds =
    Internal.incrementMilliseconds



-- Decrement values


{-| Decrements the `Year` in a given [DateTime](DateTime#DateTime) while preserving the `Month` and `Day`.
_The [Time](Clock#Time) related parts will remain the same._

    -- dateTime  == 31 Jan 2019 15:30:45.100
    decrementYear dateTime -- 31 Jan 2018 15:30:45.100 : DateTime

    -- dateTime2 == 29 Feb 2020 15:30:45.100
    decrementYear dateTime2 -- 28 Feb 2019 15:30:45.100 : DateTime

**Note:** In the first example, decrementing the `Year` causes no changes in the `Month` and `Day` parts.
On the second example we see that the `Day` part is different than the input. This is because the resulting date in the `DateTime`
would be an invalid date ( _**29th of February 2019**_ ). As a result of this scenario we fall back to the last valid day
of the given `Month` and `Year` combination.

-}
decrementYear : DateTime -> DateTime
decrementYear =
    Internal.decrementYear


{-| Decrements the `Month` in a given [DateTime](DateTime#DateTime). It will also roll backwards to the previous year where applicable.
_The [Time](Clock#Time) related parts will remain the same._

    -- dateTime  == 15 Sep 2019 15:30:45.100
    decrementMonth dateTime -- 15 Aug 2019 15:30:45.100 : DateTime

    -- dateTime2 == 15 Jan 2020 15:30:45.100
    decrementMonth dateTime2 -- 15 Dec 2019 15:30:45.100 : DateTime

    -- dateTime3 == 31 Dec 2019 15:30:45.100
    decrementMonth dateTime3 -- 30 Nov 2019 15:30:45.100 : DateTime

**Note:** In the first example, decrementing the `Month` causes no changes in the `Year` and `Day` parts while
on the second example it rolls backwards the `Year`. On the last example we see that the `Day` part is different
than the input. This is because the resulting date would be an invalid one ( _**31st of November 2019**_ ). As a result
of this scenario we fall back to the last valid day of the given `Month` and `Year` combination.

-}
decrementMonth : DateTime -> DateTime
decrementMonth =
    Internal.decrementMonth


{-| Decrements the `Day` in a given [DateTime](DateTime#DateTime). Will also decrement `Month` and `Year` where applicable.

    -- dateTime  == 27 Aug 2019 15:30:45.100
    decrementDay dateTime -- 26 Aug 2019 15:30:45.100 : DateTime

    -- dateTime2 == 1 Jan 2020 15:30:45.100
    decrementDay dateTime2 -- 31 Dec 2019 15:30:45.100 : DateTime

-}
decrementDay : DateTime -> DateTime
decrementDay =
    Internal.decrementDay


{-| Decrements the `Hours` in a given [DateTime](DateTime#DateTime). Will also decrement `Day`, `Month`, `Year` where applicable.

    -- dateTime  == 25 Aug 2019 15:30:45.100
    decrementHours dateTime -- 25 Aug 2019 14:30:45.100 : DateTime

    -- dateTime2 == 1 Jan 2020 00:00:00.000
    decrementHours dateTime2 -- 31 Dec 2019 23:00:00.000 : DateTime

-}
decrementHours : DateTime -> DateTime
decrementHours =
    Internal.decrementHours


{-| Decrements the `Minutes` in a given [DateTime](DateTime#DateTime). Will also decrement `Hours`, `Day`, `Month`, `Year` where applicable.

    -- dateTime  == 25 Aug 2019 15:30:45.100
    decrementMinutes dateTime -- 25 Aug 2019 15:29:45.100 : DateTime

    -- dateTime2 == 1 Jan 2020 00:00:00.000
    decrementMinutes dateTime2 -- 31 Dec 2019 23:59:00.000 : DateTime

-}
decrementMinutes : DateTime -> DateTime
decrementMinutes =
    Internal.decrementMinutes


{-| Decrements the `Seconds` in a given [DateTime](DateTime#DateTime). Will also decrement `Minutes`, `Hours`, `Day`, `Month`, `Year` where applicable.

    -- dateTime  == 25 Aug 2019 15:30:45.100
    decrementSeconds dateTime -- 25 Aug 2019 15:30:44.100 : DateTime

    -- dateTime2 == 1 Jan 2020 00:00:00.000
    decrementSeconds dateTime2 -- 31 Dec 2019 23:59:59.000 : DateTime

-}
decrementSeconds : DateTime -> DateTime
decrementSeconds =
    Internal.decrementSeconds


{-| Decrements the `Milliseconds` in a given [DateTime](DateTime#DateTime). Will also decrement `Seconds`, `Minutes`, `Hours`, `Day`, `Month`, `Year` where applicable.

    -- dateTime  == 25 Aug 2019 15:30:45.100
    decrementMilliseconds dateTime -- 25 Aug 2019 15:30:45.099 : DateTime

    -- dateTime2 == 1 Jan 2020 00:00:00.000
    decrementMilliseconds dateTime2 -- 31 Dec 2019 23:59:59.999 : DateTime

-}
decrementMilliseconds : DateTime -> DateTime
decrementMilliseconds =
    Internal.decrementMilliseconds



-- Compare values


{-| Compares the two given [DateTimes](DateTime#DateTime) and returns an [Order](https://package.elm-lang.org/packages/elm/core/latest/Basics#Order).

    -- past   == 25 Aug 2019 12:15:45.250
    -- future == 26 Aug 2019 12:15:45.250
    compare past past -- EQ : Order

    compare past future -- LT : Order

    compare future past -- GT : Order

-}
compare : DateTime -> DateTime -> Order
compare =
    Internal.compare


{-| Compares the [Date](Calendar#Date) part of two given [DateTime](DateTime#DateTime) and returns an [Order](https://package.elm-lang.org/packages/elm/core/latest/Basics#Order).

    -- dateTime  == 25 Aug 2019 12:15:45.250
    -- dateTime2 == 25 Aug 2019 21:00:00.000
    -- dateTime3 == 26 Aug 2019 12:15:45.250
    compare dateTime dateTime2 -- EQ : Order

    compare dateTime dateTime3 -- LT : Order

    compare dateTime3 dateTime2 -- GT : Order

-}
compareDates : DateTime -> DateTime -> Order
compareDates =
    Internal.compareDates


{-| Compares the [Time](Clock#Time) part of two given [DateTime](DateTime#DateTime) and returns an [Order](https://package.elm-lang.org/packages/elm/core/latest/Basics#Order).

    -- dateTime  == 25 Aug 2019 12:15:45.250
    -- dateTime2 == 25 Aug 2019 21:00:00.000
    -- dateTime3 == 26 Aug 2019 12:15:45.250
    compare dateTime dateTime3 -- EQ : Order

    compare dateTime dateTime2 -- LT : Order

    compare dateTime2 dateTime3 -- GT : Order

-}
compareTime : DateTime -> DateTime -> Order
compareTime =
    Internal.compareTime



-- Utilities


{-| Returns the Timezone Offset in Milliseconds. This function can be
used in order to form a `DateTime` that actually matches each users local `DateTime`.


    dateTime =
        DateTime.fromPosix posix

    offset =
        DateTime.getTimezoneOffset zone posix

    zonedDateTime =
        DateTime.fromPosix (posix + offset)

    -- zone == GMT+1100
    -- posix == 1554660000000 -- 2019-04-07 18:00:00 UTC
    -- dateTime == 2019-04-07 18:00:00 UTC
    -- zonedDateTime == 2019-04-08 05:00:00 GMT+1100

_The above example shows the difference between getting a `DateTime` in **UTC** and in **GMT+1100.**_

**Note:** Timezones ( and local times ) should only be used for date representation purposes and never
for storing or modeling. If you use getTimezoneOffset for constructing a _**local today**_ `DateTime`,
remember to convert it back to UTC when storing it in a database.

-}
getTimezoneOffset : Time.Zone -> Time.Posix -> Int
getTimezoneOffset =
    Internal.getTimezoneOffset


{-| Returns an incrementally sorted [DateTime](DateTime#DateTime) list based on the **start** and **end** `DateTime` parameters.
The `Time` parts of the resulting list will be equal to the `Time` argument that was provided.
_**The resulting list will include both start and end dates**_.

    -- start       == 26 Feb 2020 12:30:45.000
    -- end         == 1  Mar 2020 16:30:45.000
    -- defaultTime == 21:00:00.000

    getDateRange start end defaultTime
    -- [ 26 Feb 2020 21:00:00.000, 27 Feb 2020 21:00:00.000, 28 Feb 2020 21:00:00.000, 29 Feb 2020 21:00:00.000, 1 Mar 2020 21:00:00.000 ] : List DateTime

-}
getDateRange : DateTime -> DateTime -> Clock.Time -> List DateTime
getDateRange =
    Internal.getDateRange


{-| Returns a list of [DateTimes](DateTime#DateTime) for the given `Year` and `Month` combination.
The `Time` parts of the resulting list will be equal to the `Time` portion of the [DateTime](DateTime#DateTime)
that was provided.

    -- dateTime == 26 Aug 2019 21:00:00.000

    getDatesInMonth dateTime
    --   [ 1  Aug 2019  21:00:00.000
    --   , 2  Aug 2019  21:00:00.000
    --   , 3  Aug 2019  21:00:00.000
    --   ...
    --   , 29 Aug 2019 21:00:00.000
    --   , 30 Aug 2019 21:00:00.000
    --   , 31 Aug 2019 21:00:00.000
    --   ] : List DateTime

-}
getDatesInMonth : DateTime -> List DateTime
getDatesInMonth =
    Internal.getDatesInMonth


{-| Returns the difference in days between two [DateTimes](DateTime#DateTime).
We can have a negative difference of days as can be seen in the examples below.

    -- dateTime  == 24 Aug 2019 12:00:00.000
    -- dateTime2 == 24 Aug 2019 21:00:00.000
    -- dateTime3 == 26 Aug 2019 15:45:00.000
    getDayDiff dateTime dateTime2 -- 0 : Int

    getDayDiff dateTime dateTime3 -- 2  : Int

    getDayDiff dateTime3 dateTime -- -2 : Int

-}
getDayDiff : DateTime -> DateTime -> Int
getDayDiff =
    Internal.getDayDiff


{-| Returns the weekday of a specific [DateTime](DateTime#DateTime).

    -- dateTime == 26 Aug 2019 12:30:45.000
    getWeekday dateTime -- Mon : Weekday

-}
getWeekday : DateTime -> Time.Weekday
getWeekday =
    Internal.getWeekday


{-| Checks if the `Year` part of the given [DateTime](DateTime#DateTime) is a leap year.

    -- dateTime  == 25 Dec 2019 21:00:00.000
    isLeapYear dateTime -- False

    -- dateTime2 == 25 Dec 2020 12:00:00.000
    isLeapYear dateTime2 -- True

-}
isLeapYear : DateTime -> Bool
isLeapYear =
    Internal.isLeapYear


{-| Returns the **last day** of the combination of the `Year` and `Month` parts of the given [DateTime](DateTime#DateTime).

    -- dateTime == 1 Dec 2018 12:00:00.000
    lastDayOf dateTime -- 31 : Int

    -- dateTime2 == 1 Feb 2019 22:00:00.000
    lastDayOf dateTime2 -- 28 : Int

    -- dateTime3 = 1 Feb 2020 21:00:00.000
    lastDayOf dateTime3 -- 29 : Int

-}
lastDayOf : DateTime -> Int
lastDayOf =
    Internal.lastDayOf


{-| Sorts incrementally a list of [DateTime](DateTime#DateTime).

    -- dateTime  == 26 Aug 1920 12:30:45.000
    -- dateTime2 == 26 Aug 1920 21:00:00.000
    -- dateTime3 == 1  Jan 1970 00:00:00.000
    -- dateTime4 == 1  Jan 1970 14:40:20.120
    -- dateTime5 == 25 Dec 2020 14:40:20.120
    -- dateTime6 == 25 Dec 2020 14:40:20.150

    sort [ dateTime4, dateTime2, dateTime6, dateTime5, dateTime, dateTime3 ]
    -- [ 26 Aug 1920 12:30:45.000
    -- , 26 Aug 1920 21:00:00.000
    -- , 1  Jan 1970 00:00:00.000
    -- , 1  Jan 1970 14:40:20.120
    -- , 25 Dec 2020 14:40:20.120
    -- , 25 Dec 2020 14:40:20.120
    -- ] : List DateTime

-}
sort : List DateTime -> List DateTime
sort =
    Internal.sort
