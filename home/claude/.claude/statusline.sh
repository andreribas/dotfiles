#!/bin/bash
input=$(cat)

echo "$input" | python3 -c "
import sys, json, time, subprocess, os, re, unicodedata, shutil

d = json.load(sys.stdin)
rl = d.get('rate_limits', {})
now = time.time()
cols = shutil.get_terminal_size((120, 24)).columns

R      = '\x1b[0m'
BOLD   = '\x1b[1m'
DIM    = '\x1b[2m'
RED    = '\x1b[31m'
GREEN  = '\x1b[32m'
YELLOW = '\x1b[33m'
CYAN   = '\x1b[36m'
WHITE  = '\x1b[97m'

def cpct(p):
    if p >= 80: return RED
    if p >= 50: return YELLOW
    return GREEN

ANSI_RE = re.compile(r'\x1b\[[0-9;]*m')
def vlen(s):
    clean = ANSI_RE.sub('', s)
    w = 0
    for ch in clean:
        eaw = unicodedata.east_asian_width(ch)
        w += 2 if eaw in ('W', 'F') else 1
    return w

ws = d.get('workspace', {})
cwd = ws.get('current_dir', os.getcwd())
repo = ws.get('repo') or {}
repo_name = repo.get('name', '')
display_name = repo_name if repo_name else os.path.basename(cwd)

def git(cmd):
    try:
        return subprocess.check_output(['git', '-C', cwd] + cmd, stderr=subprocess.DEVNULL, text=True).strip()
    except:
        return ''

in_git = bool(git(['rev-parse', '--git-dir']))
git_str = ''
if in_git:
    branch = git(['rev-parse', '--abbrev-ref', 'HEAD']) or '?'
    lines = git(['status', '--short']).splitlines()
    staged    = sum(1 for l in lines if len(l) > 1 and l[0] in 'AMDRC' and l[0] != ' ')
    modified  = sum(1 for l in lines if len(l) > 1 and l[1] in 'MD')
    untracked = sum(1 for l in lines if l.startswith('??'))
    ahead  = git(['rev-list', '--count', '@{u}..HEAD'])
    behind = git(['rev-list', '--count', 'HEAD..@{u}'])

    parts = [CYAN + '⎇ ' + branch + R]
    if staged    and int(staged)    > 0: parts.append(GREEN  + f'+{staged}'    + R)
    if modified  and int(modified)  > 0: parts.append(YELLOW + f'~{modified}'  + R)
    if untracked and int(untracked) > 0: parts.append(DIM    + f'?{untracked}' + R)
    if ahead     and int(ahead)     > 0: parts.append(WHITE  + f'↑{ahead}'  + R)
    if behind    and int(behind)    > 0: parts.append(WHITE  + f'↓{behind}' + R)
    git_str = '  ' + ' '.join(parts)

left = BOLD + WHITE + display_name + R + git_str

def bar(pct, width=4):
    pct = max(0, min(100, int(round(float(pct)))))
    filled = round(pct / 100 * width)
    c = cpct(pct)
    return c + '█' * filled + DIM + '░' * (width - filled) + R

def fmt_pct(pct):
    p = int(round(float(pct)))
    return cpct(p) + f'{p}%' + R

def time_until(ts):
    if not ts: return ''
    diff = int(ts - now)
    if diff <= 0: return DIM + '(now)' + R
    total_min = diff // 60
    h, m = divmod(total_min, 60)
    days = h // 24; h = h % 24
    if days > 0:   s = f'({days}d{h}h)'
    elif h > 0:    s = f'({h}h{m:02d}m)'
    else:          s = f'({m}m)'
    return DIM + s + R

fh  = rl.get('five_hour', {})
wk  = rl.get('seven_day', {})
ctx = d.get('context_window', {})

fh_pct  = float(fh.get('used_percentage', 0))
wk_pct  = float(wk.get('used_percentage', 0))
ctx_pct = float(ctx.get('used_percentage', 0))

fh_reset = time_until(fh.get('resets_at'))
wk_reset = time_until(wk.get('resets_at'))

# MCP status — reads from cache, triggers background refresh when stale
MCP_CACHE = os.path.expanduser('~/.claude/mcp-status-cache.json')
MCP_UPDATER = os.path.expanduser('~/.claude/mcp-cache-update.sh')
MCP_TTL = 300  # seconds

mcp_servers = []
try:
    st = os.stat(MCP_CACHE)
    if now - st.st_mtime >= MCP_TTL:
        subprocess.Popen(['bash', MCP_UPDATER],
                         stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL,
                         start_new_session=True)
    with open(MCP_CACHE) as f:
        mcp_servers = json.load(f).get('servers', [])
except:
    subprocess.Popen(['bash', MCP_UPDATER],
                     stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL,
                     start_new_session=True)

connected = [s for s in mcp_servers if s.get('connected')]
high_cnt  = sum(1 for s in connected if s.get('high'))
low_cnt   = sum(1 for s in connected if not s.get('high'))

if connected:
    parts = []
    if high_cnt:
        c = RED if high_cnt >= 3 else YELLOW
        parts.append(c + f'↑{high_cnt}' + R)
    if low_cnt:
        parts.append(GREEN + f'↓{low_cnt}' + R)
    mcp_str = DIM + 'MCP: ' + R + ' '.join(parts)
else:
    mcp_str = DIM + 'MCP: 0' + R

model_info = d.get('model', {})
model_name = model_info.get('display_name', '') if isinstance(model_info, dict) else ''
model_id   = (model_info.get('id', '') if isinstance(model_info, dict) else '').lower()
fast_mode  = d.get('fast_mode', False)
if model_name:
    if   'haiku'  in model_id: mc = '\x1b[38;5;214m'
    elif 'opus'   in model_id: mc = '\x1b[35m'
    elif 'fable'  in model_id: mc = '\x1b[34m'
    else:                      mc = CYAN  # sonnet e outros
    model_str = DIM + 'M: ' + R + mc + model_name + R
    if fast_mode:
        model_str += ' ' + DIM + 'fast' + R
else:
    model_str = ''

SEP = DIM + ' │ ' + R

def stat(label, pct, reset=''):
    parts = [DIM + label + R, bar(pct), fmt_pct(pct)]
    if reset: parts.append(reset)
    return ' '.join(p for p in parts if p).strip()

right_parts = []
if model_str:
    right_parts.append(model_str)
if mcp_str:
    right_parts.append(mcp_str)
right_parts += [
    stat('5h',  fh_pct,  fh_reset),
    stat('wk',  wk_pct,  wk_reset),
    stat('ctx', ctx_pct),
]
right = SEP.join(right_parts)

pad = max(1, cols - vlen(left) - vlen(right) - 4)
print(left + ' ' * pad + right)
" 2>/dev/null
