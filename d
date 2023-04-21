package com.yhl.lib.demo.test;

/**
 * 飞天 创建
 * on 4/21/2023 9:17 AM
 */

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class CombinationFinder {

    public static void main(String[] args) {
        List<List<Member>> lists = generateLists();
        System.out.println(lists);
        List<Member> result = findCombinations(lists);
        System.out.println("最小误差为：" + calculateError(result));
        System.out.println("误差最小的组合为：" + result);
    }

    // 生成模拟数据
    private static List<List<Member>> generateLists() {

        Map<Integer, Integer> testPositions = new HashMap<>();
        testPositions.put(1, 80);
        testPositions.put(2, 90);
        testPositions.put(3, 100);
        testPositions.put(4, 110);
        testPositions.put(5, 120);
        testPositions.put(6, 130);

        //需要测试的试剂的量，以及允许的范围
        Map<Integer, MemberSelection.Count> reagentsMap = new HashMap<>();
        reagentsMap.put(1, new MemberSelection.Count(95, 110, 80));
        reagentsMap.put(2, new MemberSelection.Count(85, 90, 80));
        reagentsMap.put(3, new MemberSelection.Count(110, 130, 110));
        reagentsMap.put(4, new MemberSelection.Count(100, 120, 80));
        reagentsMap.put(5, new MemberSelection.Count(100, 110, 90));
        reagentsMap.put(6, new MemberSelection.Count(100, 120, 80));

        List<List<Member>> lists = new ArrayList<>();
        for (int i = 1; i <= testPositions.size(); i++) {
            int target = testPositions.get(i);
            List<Member> listMember = new ArrayList<>();
            for (int i1 = 1; i1 <= reagentsMap.size(); i1++) {
                //计算 position 与 od。
                MemberSelection.Count c = reagentsMap.get(i1);
                if (target >= c.LowCount && target <= c.UpCount) {
                    Member member = new Member(i1, Math.abs(c.getRealCount()-target));
                    listMember.add(member);
                }
            }
            lists.add(listMember);
        }
        return lists;
    }

    public static List<Member> findCombinations(List<List<Member>> lists) {
        List<Member> result = new ArrayList<>();
        findCombinationsHelper(lists, 0, new ArrayList<>(), result);
        return result;
    }

    private static void findCombinationsHelper(List<List<Member>> lists, int index, List<Member> current, List<Member> result) {
        if (index == lists.size()) {
            if (calculateError(current) < calculateError(result)) {
                result.clear();
                result.addAll(current);
            }
            return;
        }
        List<Member> list = lists.get(index);
        for (Member member : list) {
            if (!isPositionUsed(member.getPosition(), current)) {
                current.add(member);
                findCombinationsHelper(lists, index + 1, current, result);
                current.remove(current.size() - 1);
            }
        }
    }

    private static boolean isPositionUsed(int position, List<Member> current) {
        for (Member member : current) {
            if (member.getPosition() == position) {
                return true;
            }
        }
        return false;
    }

    private static int calculateError(List<Member> members) {
        int sum = 0;
        for (Member member : members) {
            sum += member.getOd();
        }
        return sum;
    }

    private static class Member {
        private int position;
        private int od;

        public Member(int position, int od) {
            this.position = position;
            this.od = od;
        }

        public int getPosition() {
            return position;
        }

        public void setPosition(int position) {
            this.position = position;
        }

        public int getOd() {
            return od;
        }

        public void setOd(int od) {
            this.od = od;
        }

        @Override
        public String toString() {
            return "" + position ;
        }
    }

}
