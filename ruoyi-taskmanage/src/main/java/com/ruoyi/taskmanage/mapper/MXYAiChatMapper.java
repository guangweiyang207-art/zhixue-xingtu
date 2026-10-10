package com.ruoyi.taskmanage.mapper;

import com.ruoyi.taskmanage.domain.AiChat;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface MXYAiChatMapper {

    List<AiChat> selectAiChatList(AiChat aiChat);

    AiChat selectAiChatById(@Param("chatId") Long chatId);

    /** 统计未回答的提问(answer 为空或 null) */
    long countUnanswered();

    int insertAiChat(AiChat aiChat);

    int updateAiChat(AiChat aiChat);

    int deleteAiChatById(@Param("chatId") Long chatId);
}
