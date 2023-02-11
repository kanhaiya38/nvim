local cp_boilerplate = {
  t({
    '#include <bits/stdc++.h>',
    'using namespace std;',
    '',
    '#define endl "\\n"',
    '#define print(arg) cout << #arg << " is " << arg << endl',
    '#define all(arg) arg.begin(), arg.end()',
    '#define sz(arg) (int)arg.size()',
    '',
    'using ll = long long;',
    'using vi = vector<int>;',
    'using vll = vector<long long>;',
    '',
    'void solve() {',
    '\t',
  }),
  i(1, '// solution'),
  t({
    '',
    '}',
    '',
    'int main() {',
    '#ifndef DEBUG',
    '\tios::sync_with_stdio(false);',
    '\tcin.tie(nullptr);',
    '#endif',
    '\tint t;',
    '\tcin >> t;',
    '\twhile (t--) solve();',
    '\treturn 0;',
    '}',
  }),
}
return {
  s('cpp', cp_boilerplate),
}