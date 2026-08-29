# Global preferences (all projects)

## Response timestamps

Begin every assistant response with a timestamp, then the message. Render the
timestamp in **bold** (Markdown `**…**`). Format:
`M/D/YY H:MMa/p` — no leading zeros on month/day/hour, 2-digit year, 12-hour
clock with a single lowercase `a`/`p` suffix. Example: `**7/19/26 11:03p**`.

- For a response triggered by a background event (monitor/task/agent
  notification), use **that event's own timestamp** (the moment it happened),
  not the time you're typing.
- For a direct reply to the user, use the **current** time.
