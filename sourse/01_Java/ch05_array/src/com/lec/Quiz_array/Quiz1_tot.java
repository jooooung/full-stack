package com.lec.Quiz_array;
//�迭�� ��� ���� ���ϴ� ���α׷��� �ۼ�
//int[] arr =  { 10, 20, 30, 40, 50}
public class Quiz1_tot {
	public static void main(String[] args) {
		int[] arr = {10, 20, 30, 40, 50};
		int tot = 0;
		for(int j : arr) {
			tot += j;
		}	
		System.out.println("tot ="+ tot);
	}
}