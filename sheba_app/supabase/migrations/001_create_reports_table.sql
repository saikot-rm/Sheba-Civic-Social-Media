CREATE TABLE reports (
  id SERIAL PRIMARY KEY,
  category VARCHAR NOT NULL,
  title VARCHAR NOT NULL,
  description TEXT NOT NULL,
  location VARCHAR NOT NULL,
  photo_url VARCHAR
  -- Create reports table
CREATE TABLE reports (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
  issue_type TEXT NOT NULL,
  location TEXT NOT NULL,
  description TEXT NOT NULL,
  image_url TEXT,
  status TEXT DEFAULT 'pending' NOT NULL
);

-- Enable Row Level Security (RLS)
ALTER TABLE reports ENABLE ROW LEVEL SECURITY;

-- Create policy to allow anonymous inserts
CREATE POLICY "Allow anonymous inserts" ON reports
  FOR INSERT
  TO anon
  WITH CHECK (true);

-- Create policy to allow public reads
CREATE POLICY "Allow public reads" ON reports
  FOR SELECT
  TO anon
  USING (true);

-- Create index for faster queries
CREATE INDEX reports_created_at_idx ON reports(created_at DESC);
);