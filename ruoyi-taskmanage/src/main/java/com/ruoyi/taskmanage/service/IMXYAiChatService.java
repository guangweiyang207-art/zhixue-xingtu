package com.ruoyi.taskmanage.service;

import com.ruoyi.taskmanage.domain.AiChat;
import java.util.List;

public interface IMXYAiChatService {
    List<AiChat> selectAiChatList(AiChat aiChat);
    AiChat selectAiChatById(Long chatId);
    long countUnanswered();
    int insertAiChat(AiChat aiChat);
    int updateAiChat(AiChat aiChat);
    int deleteAiChatById(Long chatId);
}
