PRAGMA foreign_keys = 1;

CREATE TABLE feeds (
    url TEXT PRIMARY KEY,
    title TEXT,
    canonical_url TEXT,
    author TEXT
);

CREATE TABLE entries (
    id TEXT NOT NULL,
    feed TEXT NOT NULL REFERENCES feeds (url),
    title TEXT,
    link TEXT NOT NULL,
    date REAL NOT NULL,
    PRIMARY KEY (id, feed)
);

CREATE TABLE tags (
    entry TEXT NOT NULL,
    feed TEXT NOT NULL,
    tag TEXT NOT NULL,
    FOREIGN KEY (entry, feed) REFERENCES entries (id, feed)
);

.mode csv
.import data/feeds.csv    feeds
.import data/entries.csv  entries
.import data/tags.csv     tags

.once transient/hours.csv
SELECT tag,
       cast(strftime('%H', date, 'unixepoch', 'localtime') AS INT) AS hour,
       count(id) AS count
FROM entries
JOIN tags ON tags.entry = entries.id AND tags.feed = entries.feed
GROUP BY tag, hour;

.once transient/weekdays.csv
SELECT tag,
       cast(strftime('%w', date, 'unixepoch', 'localtime') AS INT) AS day,
       count(id) AS count
FROM entries
JOIN tags ON tags.entry = entries.id AND tags.feed = entries.feed
GROUP BY tag, day;

.once transient/months.csv
SELECT tag,
       cast(strftime('%m', date, 'unixepoch', 'localtime') AS INT) AS day,
       count(id) AS count
FROM entries
JOIN tags ON tags.entry = entries.id AND tags.feed = entries.feed
GROUP BY tag, day;

.once transient/lengths.csv
SELECT length(title) AS length,
       count(*) AS count
FROM entries
GROUP BY length
ORDER BY length;

.once transient/lengths-by-tag.csv
SELECT tag,
       length(title) AS length,
       count(*) AS count
FROM entries
JOIN tags ON tags.entry = entries.id AND tags.feed = entries.feed
GROUP BY tag, length
ORDER BY length;

.once transient/length-vs-daytime.csv
SELECT (date % (24*60*60)) / (60*60) AS day_time,
       length(title) AS length
FROM entries
JOIN tags ON tags.entry = entries.id AND tags.feed = entries.feed;
