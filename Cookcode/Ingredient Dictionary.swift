//
//  Ingredient Dictionary2.swift
//  Cookcode
//
//  Created by 노우영 on 2023/05/16.
//

import Foundation


let INGREDIENTS_DICTIONARY: [Int: IngredientCell] = [
    1 : IngredientCell(thumbnail: "meat", title: "삼겹살", ingredId: 1, ingredientType: .meat),
    2 : IngredientCell(thumbnail: "meat", title: "돼지 목살", ingredId: 2, ingredientType: .meat),
    3 : IngredientCell(thumbnail: "meat", title: "돼지 갈비", ingredId: 3, ingredientType: .meat),
    4 : IngredientCell(thumbnail: "meat", title: "닭 한마리", ingredId: 4, ingredientType: .meat),
    5 : IngredientCell(thumbnail: "meat", title: "닭 가슴살", ingredId: 5, ingredientType: .meat),
    6 : IngredientCell(thumbnail: "meat", title: "소고기 등심", ingredId: 6, ingredientType: .meat),
    7 : IngredientCell(thumbnail: "meat", title: "소고기 안심", ingredId: 7, ingredientType: .meat),
    8 : IngredientCell(thumbnail: "meat", title: "소갈비", ingredId: 8, ingredientType: .meat),
    9 : IngredientCell(thumbnail: "meat", title: "베이컨", ingredId: 9, ingredientType: .meat),
    10 : IngredientCell(thumbnail: "meat", title: "소세지", ingredId: 10, ingredientType: .meat),
    11 : IngredientCell(thumbnail: "meat", title: "계란", ingredId: 11, ingredientType: .meat),
    
    12 : IngredientCell(thumbnail: "fish", title: "연어", ingredId: 12, ingredientType: .seafood),
    13 : IngredientCell(thumbnail: "fish", title: "고등어", ingredId: 13, ingredientType: .seafood),
    14 : IngredientCell(thumbnail: "fish", title: "갈치", ingredId: 14, ingredientType: .seafood),
    15 : IngredientCell(thumbnail: "fish", title: "참치", ingredId: 15, ingredientType: .seafood),
    16 : IngredientCell(thumbnail: "fish", title: "멸치", ingredId: 16, ingredientType: .seafood),
    17 : IngredientCell(thumbnail: "fish", title: "새우", ingredId: 17, ingredientType: .seafood),
    18 : IngredientCell(thumbnail: "fish", title: "굴", ingredId: 18, ingredientType: .seafood),
    19 : IngredientCell(thumbnail: "fish", title: "오징어", ingredId: 19, ingredientType: .seafood),
    20 : IngredientCell(thumbnail: "fish", title: "문어", ingredId: 20, ingredientType: .seafood),
    21 : IngredientCell(thumbnail: "fish", title: "미역", ingredId: 21, ingredientType: .seafood),
    
    22 : IngredientCell(thumbnail: "milk", title: "우유", ingredId: 22, ingredientType: .diaryProducts),
    23 : IngredientCell(thumbnail: "milk", title: "치즈", ingredId: 23, ingredientType: .diaryProducts),
    24 : IngredientCell(thumbnail: "milk", title: "버터", ingredId: 24, ingredientType: .diaryProducts),
    25 : IngredientCell(thumbnail: "milk", title: "생크림", ingredId: 25, ingredientType: .diaryProducts),
    
    26 : IngredientCell(thumbnail: "rice", title: "쌀", ingredId: 26, ingredientType: .rice),
    27 : IngredientCell(thumbnail: "rice", title: "보리", ingredId: 27, ingredientType: .rice),
    28 : IngredientCell(thumbnail: "rice", title: "밀가루", ingredId: 28, ingredientType: .rice),
    29 : IngredientCell(thumbnail: "rice", title: "옥수수", ingredId: 29, ingredientType: .rice),
    30 : IngredientCell(thumbnail: "rice", title: "콩", ingredId: 30, ingredientType: .rice),
    31 : IngredientCell(thumbnail: "rice", title: "면", ingredId: 31, ingredientType: .rice),
    
    32 : IngredientCell(thumbnail: "vegetables", title: "양파", ingredId: 32, ingredientType: .vegetables),
    33 : IngredientCell(thumbnail: "vegetables", title: "마늘", ingredId: 33, ingredientType: .vegetables),
    34 : IngredientCell(thumbnail: "vegetables", title: "당근", ingredId: 34, ingredientType: .vegetables),
    35 : IngredientCell(thumbnail: "vegetables", title: "오이", ingredId: 35, ingredientType: .vegetables),
    36 : IngredientCell(thumbnail: "vegetables", title: "배추", ingredId: 36, ingredientType: .vegetables),
    37 : IngredientCell(thumbnail: "vegetables", title: "파", ingredId: 37, ingredientType: .vegetables),
    38 : IngredientCell(thumbnail: "vegetables", title: "고추", ingredId: 38, ingredientType: .vegetables),
    39 : IngredientCell(thumbnail: "vegetables", title: "깻잎", ingredId: 39, ingredientType: .vegetables),
    40 : IngredientCell(thumbnail: "vegetables", title: "상추", ingredId: 40, ingredientType: .vegetables),
    41 : IngredientCell(thumbnail: "vegetables", title: "콩나물", ingredId: 41, ingredientType: .vegetables),
    42 : IngredientCell(thumbnail: "vegetables", title: "버섯", ingredId: 42, ingredientType: .vegetables),
    43 : IngredientCell(thumbnail: "vegetables", title: "무", ingredId: 43, ingredientType: .vegetables),
    44 : IngredientCell(thumbnail: "vegetables", title: "브로콜리", ingredId: 44, ingredientType: .vegetables),
    45 : IngredientCell(thumbnail: "vegetables", title: "피망", ingredId: 45, ingredientType: .vegetables),
    46 : IngredientCell(thumbnail: "vegetables", title: "감자", ingredId: 46, ingredientType: .vegetables),
    
    47 : IngredientCell(thumbnail: "apple", title: "사과", ingredId: 47, ingredientType: .fruit),
    48 : IngredientCell(thumbnail: "apple", title: "배", ingredId: 48, ingredientType: .fruit),
    49 : IngredientCell(thumbnail: "apple", title: "바나나", ingredId: 49, ingredientType: .fruit),
    50 : IngredientCell(thumbnail: "apple", title: "토마토", ingredId: 50, ingredientType: .fruit),
    
    51 : IngredientCell(thumbnail: "sauces", title: "간장", ingredId: 51, ingredientType: .sauces),
    52 : IngredientCell(thumbnail: "sauces", title: "고추장", ingredId: 52, ingredientType: .sauces),
    53 : IngredientCell(thumbnail: "sauces", title: "된장", ingredId: 53, ingredientType: .sauces),
    54 : IngredientCell(thumbnail: "sauces", title: "소금", ingredId: 54, ingredientType: .sauces),
    55 : IngredientCell(thumbnail: "sauces", title: "설탕", ingredId: 55, ingredientType: .sauces),
    56 : IngredientCell(thumbnail: "sauces", title: "토마토 소스", ingredId: 56, ingredientType: .sauces),
    57 : IngredientCell(thumbnail: "sauces", title: "식초", ingredId: 57, ingredientType: .sauces),
    58 : IngredientCell(thumbnail: "sauces", title: "참기름", ingredId: 59, ingredientType: .sauces),
    59 : IngredientCell(thumbnail: "sauces", title: "들기름", ingredId: 59, ingredientType: .sauces),
    60 : IngredientCell(thumbnail: "sauces", title: "초고추장", ingredId: 60, ingredientType: .sauces),
    61 : IngredientCell(thumbnail: "sauces", title: "물엿", ingredId: 61, ingredientType: .sauces),
    62 : IngredientCell(thumbnail: "sauces", title: "고춧가루", ingredId: 62, ingredientType: .sauces),
    63 : IngredientCell(thumbnail: "sauces", title: "돈까스 소스", ingredId: 63, ingredientType: .sauces),
    64 : IngredientCell(thumbnail: "sauces", title: "케찹", ingredId: 64, ingredientType: .sauces),
    65 : IngredientCell(thumbnail: "sauces", title: "머스타드", ingredId: 65, ingredientType: .sauces),
    66 : IngredientCell(thumbnail: "sauces", title: "후추", ingredId: 66, ingredientType: .sauces),
]
