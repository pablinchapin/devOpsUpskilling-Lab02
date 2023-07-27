CREATE TABLE quotes(
	id INT PRIMARY KEY AUTO_INCREMENT,
	author VARCHAR(60),
	quote VARCHAR(255)
	
);

INSERT INTO quotes(author, quote) 
VALUES
('Albert Einstein',"Imagination is more important than knowledge."),
('Socrates',"I know that I am intelligent because I know that I know nothing."),
('Lewis Carroll',"If you don't know where you are going, any road will get you there."),
('Confucius',"The man who asks a question is a fool for a minute, the man who does not ask is a fool for life."),
('Maya Angelou',"I've learned that people will forget what you said, people will forget what you did, but people will never forget how you made them feel."),
('Ralph Waldo Emerson',"Do not go where the path may lead, go instead where there is no path and leave a trail."),
('Mark Twain',"The two most important days in your life are the day you are born and the day you find out why."),
('Aristotle',"The roots of education are bitter, but the fruit is sweet."),
('Nelson Mandela',"Education is the most powerful weapon which you can use to change the world."),
('Jane Austen',"It isn't what we say or think that defines us, but what we do."),
('Confucius',"Choose a job you love, and you will never have to work a day in your life."),
('Vincent van Gogh',"I dream my painting and I paint my dream."),
('Lao Tzu',"The journey of a thousand miles begins with a single step."),
('Emily Dickinson',"Hope is the thing with feathers that perches in the soul and sings the tune without the words and never stops at all."),
('Confucius',"Life is really simple, but we insist on making it complicated.");


ALTER USER 'root' IDENTIFIED WITH mysql_native_password BY 'super-secret';

flush privileges;