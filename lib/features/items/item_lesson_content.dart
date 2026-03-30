class ItemLessonContent {
  const ItemLessonContent({
    required this.id,
    required this.title,
    required this.overview,
    required this.keyPoints,
    required this.exampleCode,
    required this.practiceChecklist,
  });

  final String id;
  final String title;
  final String overview;
  final List<String> keyPoints;
  final String exampleCode;
  final List<String> practiceChecklist;
}

const repositoryLessonContentById = <String, ItemLessonContent>{
  'i1': ItemLessonContent(
    id: 'i1',
    title: 'レイアウトの基本',
    overview:
        'Flutter の画面は Widget を積み重ねて作ります。まずは Row、Column、Expanded、Padding を使って、縦横の並びや余白の考え方を身につけます。',
    keyPoints: [
      'Row は横方向、Column は縦方向に子 Widget を並べる',
      'Expanded を使うと余っている空間を割合で使える',
      'Padding は外側に余白を作る基本 Widget',
      'mainAxisAlignment と crossAxisAlignment で揃え方を調整する',
    ],
    exampleCode: '''
Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    const Text('Flutter レイアウト'),
    const SizedBox(height: 12),
    Row(
      children: const [
        Expanded(child: Card(child: Padding(
          padding: EdgeInsets.all(16),
          child: Text('左'),
        ))),
        SizedBox(width: 12),
        Expanded(child: Card(child: Padding(
          padding: EdgeInsets.all(16),
          child: Text('右'),
        ))),
      ],
    ),
  ],
)
''',
    practiceChecklist: [
      'Column と Row を使って 2 段構成の UI を作る',
      'Expanded で横並びのカード幅を揃える',
      'Padding と SizedBox で余白を調整する',
    ],
  ),
  'i2': ItemLessonContent(
    id: 'i2',
    title: 'Widget の種類を理解する',
    overview:
        'Flutter では画面の見た目も動きも Widget で表現します。状態を持たない StatelessWidget と、状態を持つ StatefulWidget の使い分けが基本です。',
    keyPoints: [
      'StatelessWidget は表示専用の部品に向いている',
      'StatefulWidget は入力値や選択状態など変化する値を持てる',
      'build メソッドは状態に応じて UI を再構築する',
      '小さな責務ごとに Widget を分けると読みやすくなる',
    ],
    exampleCode: '''
class CounterChip extends StatefulWidget {
  const CounterChip({super.key});

  @override
  State<CounterChip> createState() => _CounterChipState();
}

class _CounterChipState extends State<CounterChip> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return ActionChip(
      label: Text('回数: \$count'),
      onPressed: () => setState(() => count++),
    );
  }
}
''',
    practiceChecklist: [
      '表示専用のカードを StatelessWidget で切り出す',
      'ボタン押下で数値が変わる部品を StatefulWidget で作る',
      '状態を持つ必要があるかを先に判断する',
    ],
  ),
  'i3': ItemLessonContent(
    id: 'i3',
    title: '画面遷移とルーティング',
    overview:
        'アプリでは複数画面を行き来します。Flutter では Navigator や go_router を使って画面を開き、必要な値を次の画面へ渡します。',
    keyPoints: [
      'push で次の画面を開き、pop で戻る',
      'パスパラメータやクエリで詳細画面に値を渡せる',
      'ルーティング定義を 1 か所にまとめると管理しやすい',
      '一覧から詳細へ遷移する流れは学習アプリでも基本',
    ],
    exampleCode: '''
ListTile(
  title: const Text('詳細を見る'),
  onTap: () {
    context.push('/items/layout');
  },
)
''',
    practiceChecklist: [
      '一覧画面から詳細画面へ遷移する',
      'ID やタイトルをルートで渡す',
      '戻る操作後も状態が崩れないことを確認する',
    ],
  ),
  'i4': ItemLessonContent(
    id: 'i4',
    title: 'フォーム入力とバリデーション',
    overview:
        'ログインや登録画面ではフォームが重要です。TextFormField、Form、validator を使って安全に入力を受け取りましょう。',
    keyPoints: [
      'Form と GlobalKey で入力全体を管理する',
      'validator で未入力や形式エラーを検査する',
      'TextEditingController で入力値を扱える',
      '送信前に validate を呼ぶのが基本',
    ],
    exampleCode: '''
final _formKey = GlobalKey<FormState>();

if (_formKey.currentState!.validate()) {
  // 入力が正しいときだけ送信
}
''',
    practiceChecklist: [
      '必須入力チェックを追加する',
      'メールアドレス入力欄を作る',
      '送信成功時と失敗時のメッセージを分ける',
    ],
  ),
  'i5': ItemLessonContent(
    id: 'i5',
    title: '状態管理の第一歩',
    overview: '小さな画面では setState が最もシンプルです。どの値が変わるのかを明確にして、必要な範囲だけ更新する感覚をつかみます。',
    keyPoints: [
      'setState は状態が変わったことを Flutter に知らせる',
      'UI に必要な値だけ State に持つ',
      '処理が複雑になってきたら Provider などへ分離する',
      '読みやすさのため更新箇所をまとめる',
    ],
    exampleCode: '''
setState(() {
  isDone = true;
  completedCount++;
});
''',
    practiceChecklist: [
      'true/false の状態切り替えを実装する',
      'カウントアップ UI を作る',
      '複数の状態がある場合に整理して命名する',
    ],
  ),
  'i6': ItemLessonContent(
    id: 'i6',
    title: '非同期処理と Future',
    overview:
        'API 通信や DB 読み込みはすぐには終わりません。Future、async/await、FutureBuilder を使って待機中と完了後の UI を分けます。',
    keyPoints: [
      'async/await で非同期処理を同期処理のように書ける',
      'FutureBuilder は読み込み中、成功、失敗を描き分ける',
      '通信中はローディング表示を出す',
      '完了前に null を前提にしない',
    ],
    exampleCode: '''
FutureBuilder(
  future: repository.getItems(),
  builder: (context, snapshot) {
    if (snapshot.connectionState != ConnectionState.done) {
      return const CircularProgressIndicator();
    }
    return Text('件数: \${snapshot.data?.length ?? 0}');
  },
)
''',
    practiceChecklist: ['ローディング表示を出す', 'データが空のときの表示を作る', '失敗時メッセージを用意する'],
  ),
  'i7': ItemLessonContent(
    id: 'i7',
    title: 'HTTP と JSON',
    overview: '実際のアプリは API と通信します。JSON を Dart のオブジェクトとして扱い、表示に必要な形へ整えるのが基本です。',
    keyPoints: [
      'HTTP レスポンスは文字列として返ることが多い',
      'jsonDecode で Map や List に変換できる',
      'モデルクラスに詰め替えると安全に扱える',
      '通信失敗時の処理を必ず考える',
    ],
    exampleCode: '''
final json = {
  'title': 'Flutter',
  'level': 'beginner',
};

final title = json['title'] as String;
''',
    practiceChecklist: ['JSON のキーから値を取り出す', 'モデルクラスへ変換する', '例外発生時の表示を確認する'],
  ),
  'i8': ItemLessonContent(
    id: 'i8',
    title: 'Provider 入門',
    overview:
        '画面をまたぐ状態共有には Provider が便利です。コントローラを 1 か所で持ち、複数画面から watch/read で使う流れを理解します。',
    keyPoints: [
      'ChangeNotifier は状態変化を通知できる',
      'watch は再描画込み、read は処理呼び出し向け',
      'アプリ全体の状態は上位で Provider に入れる',
      'UI と状態更新ロジックを分離しやすい',
    ],
    exampleCode: '''
final controller = context.watch<LearningController>();

Text('完了数: \${controller.learnedLessonsCount}');
''',
    practiceChecklist: [
      'Provider でコントローラを注入する',
      'watch と read を使い分ける',
      'notifyListeners の役割を確認する',
    ],
  ),
};
