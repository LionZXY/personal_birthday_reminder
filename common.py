from datetime import datetime
from pathlib import Path

import dateparser


class Birthday:
    def __init__(self, time: datetime, name, nickname):
        self.time = time
        self.name = name
        self.nickname = nickname


def parse_birthdays():
    birthday_raw = Path('birthday.csv').read_text().split('\n')
    birthday_rows = [row.split(',') for row in birthday_raw if len(row) >= 2]
    return [
        Birthday(
            time=dateparser.parse(row[0]),
            name=row[1].strip(),
            nickname=row[2] if len(row) > 2 else None
        )
        for row in birthday_rows
    ]


print(parse_birthdays())
