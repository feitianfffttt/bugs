    public static Map<String, List<String>> searchAndPrintLinesBefore(String file, String[] searchStrings, int numLinesBefore) {
        Map<String, List<String>> results = new HashMap<>(); // 存储搜索结果
        try (BufferedReader br = new BufferedReader(new FileReader(file))) {
            String line;
            List<String> lines = new ArrayList<>();
            while ((line = br.readLine()) != null) {
                lines.add(line);
                if (lines.size() > numLinesBefore) {
                    lines.remove(0);
                }
                for (String searchString : searchStrings) {
                    if (line.contains(searchString)) {
                        int startIndex = Math.max(lines.size() - numLinesBefore, 0);
                        List<String> l = new ArrayList<>();
                        for (int i = startIndex; i < lines.size(); i++) {
                            l.add(lines.get(i));
                        }
                        results.put(searchString, l);
                    }
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return results;
    }
