import std.stdio : stderr, stdout;
import std.range.primitives : walkLength;
import std.file : isFile, exists, readText;
import std.algorithm.searching : countUntil;
import std.range : repeat, take;
import std.uni : byCodePoint;

/// 変換対象のひらがな
static immutable dchar[] hiragana = "あいうえおかがきぎくぐけげこごさざしじすずせぜそぞただちぢつづてでとどなにぬねのはばぱひびぴふぶぷへべぺほぼぽまみむめもやゆよらりるれろわゐゑをんゔ";

static immutable string[16] phrases = [
	"D言語くんかわいい", "超かわいい", "D言語くん",
	"D言語くん超かわいい", "出ておいで", "反対側見せて",
	"穴くぐらせて", "かわいいなあ", "色が", "ッハァ",
	"色がきれい", "……", "ゥグウウウ", "ああああ",
	"マジでかわいい……", "いやあああ"
];

void main(string[] args)
{
	string input_text;
	if (1 < args.length && exists(args[1]) && isFile(args[1]))
	{
		input_text = readText(args[1]);
	}
	else
	{
		stderr.writeln("D言語くんかわいい！");
		return;
	}
	foreach (input_char; input_text.byCodePoint)
	{
		immutable index = hiragana.countUntil(input_char);
		if (index == -1)
		{
			stdout.write(input_char);
			continue;
		}

		immutable num_bang = ((index & 0b1110000) >> 4) + 1;
		immutable index_phrase = (index & 0b1111);

		stdout.write(phrases[index_phrase]);
		stdout.write(repeat('！').take(num_bang));
	}
}
