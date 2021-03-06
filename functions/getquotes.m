
function [quote]=getquotes()

% Source: https://www.goodreads.com/quotes
SuccessQuotes{1}='"Success is not final, failure is not fatal: it is the courage to continue that counts." ― Winston S. Churchill';
SuccessQuotes{2}='"I can''t give you a sure-fire formula for success, but I can give you a formula for failure: try to please everybody all the time." ― Herbert Bayard Swope';
SuccessQuotes{3}='"It is better to fail in originality than to succeed in imitation." ― Herman Melville';
SuccessQuotes{4}='"Success is getting what you want, happiness is wanting what you get" ― W. P. Kinsella';
SuccessQuotes{5}='"Failure is the condiment that gives success its flavor." ― Truman Capote';
SuccessQuotes{6}='"Have no fear of perfection - you''ll never reach it." ― Salvador Dali';
SuccessQuotes{7}='"Success is stumbling from failure to failure with no loss of enthusiasm." ― Winston S. Churchill';
SuccessQuotes{8}='"If A is a success in life, then A equals x plus y plus z. Work is x; y is play; and z is keeping your mouth shut" ― Albert Einstein';
SuccessQuotes{9}='"The way to get started is to quit talking and begin doing." ― Walt Disney';
SuccessQuotes{10}='"All you need in this life is ignorance and confidence; then success is sure." ― Mark Twain';
SuccessQuotes{11}='"It is hard to fail, but it is worse never to have tried to succeed." ― Theodore Roosevelt';
SuccessQuotes{12}='"Success is most often achieved by those who don''t know that failure is inevitable." ― Coco Chanel, Believing in Ourselves: The Wisdom of Women';
SuccessQuotes{13}='"Be yourself; everyone else is already taken." ― Oscar Wilde';
SuccessQuotes{14}='"You only live once, but if you do it right, once is enough." ― Mae West';
SuccessQuotes{15}='"Be the change that you wish to see in the world." ― Mahatma Gandhi';
SuccessQuotes{16}='"If you tell the truth, you don''t have to remember anything." ― Mark Twain';
SuccessQuotes{17}='"Always forgive your enemies; nothing annoys them so much." ― Oscar Wilde ';
SuccessQuotes{18}='"Live as if you were to die tomorrow. Learn as if you were to live forever." ― Mahatma Gandhi';
SuccessQuotes{19}='"Good friends, good books, and a sleepy conscience: this is the ideal life. ― Mark Twain';
SuccessQuotes{21}='"I have not failed. I''ve just found 10,000 ways that won''t work." ― Thomas A. Edison';
SuccessQuotes{22}='"The man who does not read has no advantage over the man who cannot read." ― Mark Twain';
SuccessQuotes{23}='"If you don''t stand for something you will fall for anything." ― Gordon A. Eadie';
SuccessQuotes{24}='"I like nonsense, it wakes up the brain cells. Fantasy is a necessary ingredient in living."― Dr. Seuss';
SuccessQuotes{25}='"That which does not kill us makes us stronger." ― Friedrich Nietzsche';
SuccessQuotes{26}='"For every minute you are angry you lose sixty seconds of happiness." ― Ralph Waldo Emerson';
SuccessQuotes{27}='"If you judge people, you have no time to love them." ― Mother Teresa';
SuccessQuotes{28}='"If you can''t explain it to a six year old, you don''t understand it yourself." ― Albert Einstein';
SuccessQuotes{29}='"Everything you can imagine is real." ― Pablo Picasso';
SuccessQuotes{30}='"Sometimes the questions are complicated and the answers are simple." ― Dr. Seuss';
SuccessQuotes{31}='"All you need is love. But a little chocolate now and then doesn''t hurt." ― Charles M. Schulz';
SuccessQuotes{32}='"If you want your children to be intelligent, read them fairy tales. If you want them to be more intelligent, read them more fairy tales." ― Albert Einstein';
SuccessQuotes{33}='"Logic will get you from A to Z; imagination will get you everywhere." ― Albert Einstein';
SuccessQuotes{34}='"Folks are usually about as happy as they make their minds up to be." ― Abraham Lincoln';
SuccessQuotes{35}='"Do what you can, with what you have, where you are." ― Theodore Roosevelt';
SuccessQuotes{36}='"Not all of us can do great things. But we can do small things with great love." ― Mother Teresa';
SuccessQuotes{37}='"The difference between genius and stupidity is: genius has its limits." ― Alexandre Dumas-fils';
SuccessQuotes{38}='"Life is like riding a bicycle. To keep your balance, you must keep moving." ― Albert Einstein';
SuccessQuotes{39}='"Some infinities are bigger than other infinities." ― John Green, The Fault in Our Stars';
SuccessQuotes{40}='"Time you enjoy wasting is not wasted time." ― Marthe Troly-Curtin, Phrynette Married';
SuccessQuotes{41}='"The reason I talk to myself is because I’m the only one whose answers I accept." ― George Carlin';
SuccessQuotes{42}='"And, when you want something, all the universe conspires in helping you to achieve it." ― Paulo Coelho, The Alchemist';
SuccessQuotes{43}='"I have never let my schooling interfere with my education." ― Mark Twain';
SuccessQuotes{44}='"Anyone who has never made a mistake has never tried anything new." ― Albert Einstein';
SuccessQuotes{45}='"Some day you will be old enough to start reading fairy tales again." ― C.S. Lewis';
SuccessQuotes{46}='"Insanity is doing the same thing, over and over again, but expecting different results." ― Narcotics Anonymous ';
SuccessQuotes{47}='"Knowing yourself is the beginning of all wisdom." ― Aristotle';
SuccessQuotes{48}='"Any fool can know. The point is to understand." ― Albert Einstein';
SuccessQuotes{49}='"The man of knowledge must be able not only to love his enemies but also to hate his friends." ― Friedrich Nietzsche';
SuccessQuotes{50}='"You will do foolish things, but do them with enthusiasm." ― Colette';
SuccessQuotes{51}='"The measure of intelligence is the ability to change." ― Albert Einstein';
SuccessQuotes{52}='"Failure is the condiment that gives success its flavor." ― Truman Capote';
SuccessQuotes{53}='"Wonder is the beginning of wisdom." ― Socrates';
SuccessQuotes{54}='"Honesty is the first chapter of the book wisdom." ― Thomas Jefferson';
SuccessQuotes{55}='"Risks must be taken because the greatest hazard in life is to risk nothing." ― Leo F. Buscaglia';
SuccessQuotes{56}='"Never complain, never explain. Resist the temptation to defend yourself or make excuses." ― Brian Tracy';
SuccessQuotes{57}='"A wise man will make more opportunities than he finds." ― Francis Bacon, The Essays';
SuccessQuotes{58}='"The only man who never makes mistakes is the man who never does anything." ― Theodore Roosevelt';
SuccessQuotes{59}='"Wisdom is not a product of schooling but of the lifelong attempt to acquire it." ― Albert Einstein';
SuccessQuotes{60}='"The art of being wise is knowing what to overlook." ― William James';

[~,y]=size(SuccessQuotes);
nq=randperm(y,1);
quote = SuccessQuotes{nq};

% '"No one can make you feel inferior without your consent." ― Eleanor Roosevelt, This is My Story'