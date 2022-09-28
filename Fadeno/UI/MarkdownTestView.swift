//
//  MarkdownTestView.swift
//  Fadeno
//
//  Created by YanunYang on 2022/9/21.
//

import SwiftUI
import UIComponent
import Markdown

struct MarkdownTestView: View {
    
    @State var text: String =
    #"""
    # Title
    hello
    this is body
    > Note really

    |C|D|C|D|
    |---|---|---|---|
    |A|B|A|B|
    
    inline `code test`
    
    ```go
    
    type VirtualCashTransactionRecord struct {
        TxID                   string      `json:"txID,omitempty"`                   // 交易TxID
        InternalTxID           string      `json:"internalTxID,omitempty"`           // 平台間內部交易TxID
        TransactionTimestamp   interface{} `json:"transactionTimestamp,omitempty"`   // 交易時間
        RemittanceAccount      string      `json:"remittanceAccount,omitempty"`      // 轉出帳戶/內部交易帳號accountID
        RemittanceAccountType  string      `json:"remittanceAccountType,omitempty"`  // 轉出帳號種類
        RemittanceCurrency     string      `json:"remittanceCurrency,omitempty"`     // 轉出幣別
        OutwardsAmount         float64     `json:"outwardsAmount,omitempty"`         // 轉出數量
        BeneficiaryAccount     string      `json:"beneficiaryAccount,omitempty"`     // 轉入帳戶/內部交易帳號accountID
        BeneficiaryCurrency    string      `json:"beneficiaryCurrency,omitempty"`    // 轉入幣別
        BeneficiaryAccountType string      `json:"beneficiaryAccountType,omitempty"` // 轉入帳號種類
        InwardsAmount          float64     `json:"inwardsAmount,omitempty"`          // 轉入數量
        TransactionStatus      string      `json:"transactionStatus,omitempty"`      // 交易狀態 success or fail
    }
    ```
    
    """#
    
    
    @FocusState private var focus: Bool
    @State private var edit: Bool = false
    
    var body: some View {
        mainView
        .padding()
        .onChange(of: self.focus) { newValue in
            if !newValue {
                self.edit = false
            }
        }
        .hotkey(key: .kVK_Escape, keyBase: []) {
            if edit {
                edit = false
                focus = false
            }
        }
        .hotkey(key: .kVK_Return, keyBase: []) {
            if !edit {
                edit = true
                focus = true
            }
        }
    }
}

// MARK: View
extension MarkdownTestView {
    var mainView: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.primary25.opacity(0.0101))
            TextEditor(text: $text)
                .font(.title3)
                .focused($focus)
                .opacity(edit ? 1 : 0)
                .disabled(!focus)
            
            Markdown(content: $text, theme: .light)
                .opacity(edit ? 0 : 1)
                .onTapGesture {
                    print("hello")
                    self.edit = true
                    self.focus = true
                }
            
        }
    }
}

struct MarkdownTestView_Previews: PreviewProvider {
    static var previews: some View {
        MarkdownTestView()
        MarkdownTestView()
            .preferredColorScheme(.dark)
    }
}
